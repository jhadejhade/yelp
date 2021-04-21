//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Jade Lapuz on 4/21/21.
//

import Foundation
import UIKit
import Combine
import CoreLocation

class BusinessesViewController: UIViewController {
    
    private struct Constants {
        static let storyboardId = "BusinessesViewController"
        static let businessCell = "BusinessTableViewCell"
        static let titleFormat = "Businesses around %@"
    }
    
    @IBOutlet private var retryButton: UIButton!
    @IBOutlet private var errorLabel: UILabel!
    @IBOutlet private var errorView: UIView!
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private var searchBar: UISearchBar!
    @IBOutlet private var tableView: UITableView!
    
    override class var storyboardID: String? {
        return Constants.storyboardId
    }
    
    var viewModel: BusinessesViewModel! {
        didSet {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sort", style: .plain, target: self, action: #selector(sortTapped))
        }
    }
    
    override func viewDidLoad() {
        setupViewsAndDelegates()
        viewModel.startUpdatingLocation()
    }
    
    private func getData(location: String?) {
        activityIndicator.startAnimating()
        
        viewModel.fetchBusinesses(location: location) { [weak self] in
            guard let self = self else {
                return
            }
            
            self.updateTableView()
            self.activityIndicator.stopAnimating()
            self.view.bringSubviewToFront(self.tableView)
        } failure: { [weak self] error in
            guard let self = self else {
                return
            }
            
            self.activityIndicator.stopAnimating()
            self.errorLabel.text = error
            self.retryButton.setTitle("Try again", for: .normal)
            self.view.bringSubviewToFront(self.errorView)
        }
    }
    
    @objc private func sortTapped() {
        let actionSheet = UIAlertController(title: "Sort by", message: "What would you like to do?", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Ratings Ascending", style: .default, handler: { [weak self] _ in
            self?.viewModel.sort(by: .ratingsAscending, completion: {
                self?.updateTableView()
            })
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Ratings Descending", style: .default, handler: { [weak self] _ in
            self?.viewModel.sort(by: .ratingsDescending, completion: {
                self?.updateTableView()
            })
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Distance Ascending", style: .default, handler: { [weak self] _ in
            self?.viewModel.sort(by: .distanceAscending, completion: {
                self?.updateTableView()
            })
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Distance Descending", style: .default, handler: { [weak self] _ in
            self?.viewModel.sort(by: .distanceDescending, completion: {
                self?.updateTableView()
            })
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    private func setupViewsAndDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        viewModel.delegate = self
        
        tableView.register(UINib(nibName: Constants.businessCell, bundle: nil), forCellReuseIdentifier: BusinessElementType.businessCell.rawValue)
    }
    
    private func updateTableView() {
        tableView.reloadData()
    }
    
    private func showPermissionError(message: String) {
        let alert = UIAlertController(title: "Ooops", message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func retryTapped(_ sender: UIButton) {
        getData(location: viewModel.lastLocation.isEmpty ? "Philippines": viewModel.lastLocation)
    }
    
}

extension BusinessesViewController: BusinessViewModelDelegate {
    
    func didUpdateLocation(placemark: CLPlacemark?, error: LocationError?) {
        if let error = error, error == .denied {
            showPermissionError(message: error.localizedDescription)
        }
        
        let location = placemark?.administrativeArea ?? "Philippines"
        title = String(format: Constants.titleFormat, location)
        getData(location: location)
    }
}

extension BusinessesViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.businesses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let business = viewModel.businesses[indexPath.row]
        business.cellType = .businessCell
        
        let cellIdentifier = business.cellType.rawValue
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? BusinessElementCell, let tableCell = cell as? UITableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(model: business)
        
        return tableCell 
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let id = viewModel.businesses[indexPath.row].id else {
            return
        }
        
        let detailsViewController = BusinessDetailsFactory.makeBusinessDetails(id: id)
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
}

extension BusinessesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.search(searchString: searchText.lowercased()) { [weak self] in
            self?.updateTableView()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
}
