//
//  BusinessDetailsViewController.swift
//  Yelp
//
//  Created by Jade Lapuz on 4/21/21.
//

import UIKit

class BusinessDetailsViewController: UIViewController {

    @IBOutlet var ratingButton: UIButton! {
        didSet {
            ratingButton.backgroundColor = .systemBlue
            ratingButton.layer.cornerRadius = 15
            ratingButton.isHidden = true
        }
    }
    
    @IBOutlet private var activitiyIndicator: UIActivityIndicatorView!
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var businessImage: UIImageView!
    
    private struct Constants {
        static let storyboardId = "BusinessDetailsViewController"
        static let detailsCell = "DetailsTableViewCell"
        static let addressCell = "AddressTableViewCell"
        static let transactionsCell = "TransactionTableViewCell"
        static let scheduleCell = "ScheduleTableViewCell"
    }
    
    override class var storyboardID: String? {
        return Constants.storyboardId
    }
    
    var viewModel: BusinessDetailsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewsAndDelegates()
        
        activitiyIndicator.startAnimating()
        viewModel.fetchBusinessDetails { [weak self] in
            guard let self = self, let business = self.viewModel.business else {
                return
            }
            
            self.activitiyIndicator.stopAnimating()
            if let imageUrl = business.imageUrl {
                self.businessImage.kf.setImage(with: URL(string: imageUrl), placeholder: UIImage(named: "placeholder"), options: nil, progressBlock: { (progress, content) in
                    
                }) { (result) in
                    
                }
            }
            
            self.ratingButton.setTitle((business.rating ?? 0).description, for: .normal)
            self.ratingButton.isHidden = false
            self.updateTableView()
        } failure: { [weak self] error in
            let alertController = UIAlertController(title: "Ooops", message: error, preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
                guard let self = self else {
                    return
                }
                
                self.navigationController?.popViewController(animated: true)
            }))
            
            self?.present(alertController, animated: true, completion: nil)
        }
        
    }
    
    private func updateTableView() {
        tableView.reloadData()
    }
    
    private func setupViewsAndDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: Constants.detailsCell, bundle: nil), forCellReuseIdentifier: BusinessElementType.detailsCell.rawValue)
        tableView.register(UINib(nibName: Constants.addressCell, bundle: nil), forCellReuseIdentifier: BusinessElementType.addressCell.rawValue)
        tableView.register(UINib(nibName: Constants.transactionsCell, bundle: nil), forCellReuseIdentifier: BusinessElementType.transactionCell.rawValue)
        tableView.register(UINib(nibName: Constants.scheduleCell, bundle: nil), forCellReuseIdentifier: BusinessElementType.scheduleCell.rawValue)
    }
}

extension BusinessDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
        default:
            return viewModel.business?.hours?.first?.open?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let business = viewModel.business
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 1:
                business?.cellType = .addressCell
            case 2:
                business?.cellType = .transactionCell
            default:
                business?.cellType = .detailsCell
            }
            
            guard let businessModel = business, let cellIdentifier = business?.cellType.rawValue, let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? BusinessElementCell, let tableCell = cell as? UITableViewCell else {
                return UITableViewCell()
            }
            
            cell.configure(model: businessModel)
            
            return tableCell
        default:
            guard let hoursModel = business?.hours?.first, let schedules = hoursModel.open else {
                return UITableViewCell()
            }
            
            let openModel = schedules[indexPath.row]
            let cellIdentifier = openModel.cellType.rawValue
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? BusinessElementCell, let tableCell = cell as? UITableViewCell else {
                return UITableViewCell()
            }
            
            cell.configure(model: openModel)
            
            return tableCell
        }
        
    }
}
