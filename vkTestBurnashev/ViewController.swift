//
//  ViewController.swift
//  vkTestBurnashev
//
//  Created by T BURNASHEVA on 05.09.2024.
//

import UIKit

protocol DelegateSmallMainCell : AnyObject {
    func clickSmallCell(indexPath: IndexPath)
}

protocol DelegateMediumMainCell : AnyObject {
    func openApps(indexPath: IndexPath)
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    static let identifier = "ViewController"
    private var appsArray : [AppsList] = []
    private var isExpand = false
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var buttonExpand: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setAppsArray()
        setButton()
        
        tableView.register(SmallMainCell.nib, forCellReuseIdentifier: SmallMainCell.identifier)
        tableView.register(MediumMainCell.nib, forCellReuseIdentifier: MediumMainCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorColor = .clear
            
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        tableView.reloadData()
    }
    
    @IBAction func clickButtonExpand(_ sender: Any) {
        isExpand = !isExpand
        setButton()
        tableView.reloadData()
    }
    
    private func setButton() {
        if isExpand {
            buttonExpand.setImage(UIImage(systemName: "arrow.down.right.and.arrow.up.left"), for: .normal)
        } else {
            buttonExpand.setImage(UIImage(systemName: "arrow.up.left.and.arrow.down.right"), for: .normal)
        }
    }
    
    private func setAppsArray() {
        
        let gallowsItem = AppsList(
            name: String(localized: "gallows"),
            image: UIImage(named: "gallows") ?? UIImage())

        let weatherItem = AppsList(
            name: String(localized: "weather"),
            image: UIImage(named: "weather") ?? UIImage())
        
        let currencyItem = AppsList(
            name: String(localized: "currency"),
            image: UIImage(named: "currency") ?? UIImage())
        
        appsArray = Array(repeating: AppsList(), count: 10)
        appsArray[0] = gallowsItem
        appsArray[1] = weatherItem
        appsArray[2] = currencyItem
        appsArray[3] = gallowsItem
        appsArray[4] = weatherItem
        appsArray[5] = currencyItem
        appsArray[6] = gallowsItem
        appsArray[7] = weatherItem
        appsArray[8] = currencyItem
        appsArray[9] = gallowsItem
        
    }


}

extension ViewController: DelegateSmallMainCell {
    func clickSmallCell(indexPath: IndexPath) {
        print("")
    }
}

extension ViewController: DelegateMediumMainCell {
    
    func openApps(indexPath: IndexPath) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if indexPath.row % 3 == 0 {
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "GallowsVC") as! GallowsVC
            self.present(newViewController, animated: true, completion: nil)
        } else if indexPath.row % 3 == 1 {
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "WeatherVC") as! WeatherVC
            self.present(newViewController, animated: true, completion: nil)
        } else {
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "CurrencyVC") as! CurrencyVC
            self.present(newViewController, animated: true, completion: nil)
        }
    }
    
}

extension ViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (isExpand) {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MediumMainCell.identifier, for: indexPath) as? MediumMainCell else { fatalError("xib doesn't exist") }
            
            cell.delegate = self
            cell.configure(index: indexPath.row, data: appsArray[indexPath.row])
            cell.imageCell.layer.cornerRadius = 16
            cell.imageCell.clipsToBounds = true
            cell.isUserInteractionEnabled = isExpand
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SmallMainCell.identifier, for: indexPath) as? SmallMainCell else { fatalError("xib doesn't exist") }
            
            cell.delegate = self
            cell.configure(index: indexPath.row, data: appsArray[indexPath.row])
            cell.imageCell.layer.cornerRadius = 16
            cell.imageCell.clipsToBounds = true
            cell.isUserInteractionEnabled = isExpand
            
            return cell
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let heightScreen = UIScreen.main.bounds.height
        if (isExpand) {
            return heightScreen / 2
        } else {
            return heightScreen / 8
        }
    }
    
}

