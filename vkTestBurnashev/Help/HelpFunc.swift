//
//  HelpFunc.swift
//  vkTestBurnashev
//
//  Created by T BURNASHEVA on 07.09.2024.
//

import Foundation
import UIKit

class HelpFunc {
    
    func loadCurrencyImage(imageView: UIImageView, index: String) {
            
            imageView.layer.cornerRadius = imageView.frame.size.height / 2
            
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                imageView.image = UIImage(named: "\(index)") ?? UIImage(named: ImagesName.defaultImages)!
                return
            }
            let managedContext = appDelegate.persistentContainer.viewContext

            let taskFetchRequest = NSFetchRequest<NSManagedObject>(entityName: currencyDataBaseString)
            let predicate = NSPredicate(format: "\(CurrencyDataBaseKey.currencyIndex) = %@", index)
            taskFetchRequest.predicate = predicate
            do {
                let foundTaskts = try managedContext.fetch(taskFetchRequest)
                if foundTaskts.count > 0 {
                    if let currencyColor = foundTaskts.first?.value(forKey: CurrencyDataBaseKey.currencyColor) as? String {
                        imageView.image = UIImage(systemName: "dollarsign.circle.fill") ?? UIImage(named: ImagesName.defaultImages)!
                        imageView.tintColor = UIColor(named: "\(currencyColor)") ?? .label
                    } else {
                        imageView.image = UIImage(named: "\(index)") ?? UIImage(named: ImagesName.defaultImages)!
                    }
                } else {
                    imageView.image = UIImage(named: "\(index)") ?? UIImage(named: ImagesName.defaultImages)!
                }
            } catch {
                imageView.image = UIImage(named: "\(index)") ?? UIImage(named: ImagesName.defaultImages)!
            }
            
        }
    
}
