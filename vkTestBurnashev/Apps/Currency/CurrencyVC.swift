//
//  CurrencyVC.swift
//  vkTestBurnashev
//
//  Created by T BURNASHEVA on 05.09.2024.
//

import UIKit

enum ImagesName {
    static let defaultImages: String = "default"
}

class CurrencyVC: UIViewController {

    static let identifier = "CurrencyVC"
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    private var ratesArray : [GlobalRates] = []
    
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        label.text = NSLocalizedString("currency", comment: "")
        tableView.register(CurrencyVCTableViewCell.nib, forCellReuseIdentifier: CurrencyVCTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorColor = .clear
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        
        updateRates(isShowSpinner: true)
        
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        tableView.reloadData()
    }
    
    @objc private func refreshData(_ sender: Any) {
        updateRates(isShowSpinner: false)
    }
    
    private func updateRates(isShowSpinner: Bool) {
        if (isShowSpinner) {
            showSpinner()
        }
        RatesManager().loadGlobalRates () { result in
            switch result {
            case .success(let arrayRates):
                self.hideSpinner()
                self.showRates(arrayRates: arrayRates)
            case .failure(_):
                self.hideSpinner()
                self.showErrorDialog()
            }
        }
    }
    
    private func showRates(arrayRates : [GlobalRates]) {
        
        DispatchQueue.main.async {
            self.ratesArray = arrayRates
            self.tableView.reloadData()
        }
        
    }

    @IBAction func clickBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func clickUpdate(_ sender: Any) {
        updateRates(isShowSpinner: true)
    }

}

extension CurrencyVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ratesArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if ratesArray[indexPath.row].rate == 0 {
            return 0
        } else {
            return 60
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyVCTableViewCell.identifier, for: indexPath) as? CurrencyVCTableViewCell else {
            fatalError("xib doesn't exist") }
        cell.configure(index: indexPath.row, data: ratesArray[indexPath.row])
        cell.imageFlag.layer.cornerRadius = 25
        cell.imageFlag.clipsToBounds = true
        return cell
    }
    
}

extension CurrencyVC {
    
    private func showErrorDialog() {
        
        let alert = UIAlertController(
            title: NSLocalizedString("currency_dialog_title", comment: ""),
            message: NSLocalizedString("currency_dialog_subtitle", comment: ""),
            preferredStyle: .alert)
         
        alert.addAction(UIAlertAction(
            title: NSLocalizedString("currency_dialog_reload", comment: ""),
            style: .default, handler: {_ in
                self.updateRates(isShowSpinner: true)
            }))
        alert.addAction(UIAlertAction(
            title: NSLocalizedString("gallows_dialog_exit", comment: ""),
            style: .cancel, handler: {_ in
                self.dismiss(animated: true)
            }))
         
        self.present(alert, animated: true)
        
    }
    
}

extension CurrencyVC {
    
    func showSpinner() {
        DispatchQueue.main.async {
                
            self.spinner.startAnimating()
            self.spinner.isHidden = false
                
            self.tableView.alpha = 0.3
                
        }
    }

    func hideSpinner() {
        DispatchQueue.main.async {
                
            self.refreshControl.endRefreshing()
                
            self.spinner.stopAnimating()
            self.spinner.isHidden = true
                
            self.tableView.alpha = 1
        }
    }
        
}
