//
//  WeatherVC.swift
//  vkTestBurnashev
//
//  Created by T BURNASHEVA on 05.09.2024.
//

import UIKit

class WeatherVC: UIViewController {

    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var frontImage: UIImageView!
    @IBOutlet weak var frontImageShadow: UIImageView!
    @IBOutlet weak var labelTemperature: UILabel!
    @IBOutlet weak var labelWind: UILabel!
    @IBOutlet weak var labelLocationShadow: UILabel!
    @IBOutlet weak var labelLocation: UILabel!
    
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var stackLocation: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        hideSpinner()
        
        self.stackLocation.addTapGestureRecognizer(isTapAnimation: true) { [weak self] in
            self!.touchView()
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        showSelectLocationDialog()
        
    }
    
    private func reloadWeather() {
        showSpinner()
        WeatherManager().loadWeather(city: labelLocation.text ?? "") {result in
            switch result {
            case .success(let weather):
                self.hideSpinner()
                self.showResult(weather: weather)
            case .failure(_):
                self.hideSpinner()
                self.showErrorDialog()
            }
        }
        
    }
    
    private func showResult(weather: WeatherList) {
        
        print("weather = ", weather)
        
        DispatchQueue.main.async {
            
            let description = weather.description
            if (description == "clear sky") {
                self.backImage.image = UIImage(named: "sunny")
                self.frontImage.image = UIImage(systemName: "sun.max.fill")
                self.frontImageShadow.image = UIImage(systemName: "sun.max.fill")
            } else if (description == "few clouds") {
                self.backImage.image = UIImage(named: "cloudy")
                self.frontImage.image = UIImage(systemName: "cloud.sun.fill")
                self.frontImageShadow.image = UIImage(systemName: "cloud.sun.fill")
            } else if (description == "scattered clouds") {
                self.backImage.image = UIImage(named: "cloudy")
                self.frontImage.image = UIImage(systemName: "cloud.sun.fill")
                self.frontImageShadow.image = UIImage(systemName: "cloud.sun.fill")
            } else if (description == "broken clouds") {
                self.backImage.image = UIImage(named: "cloudy")
                self.frontImage.image = UIImage(systemName: "cloud.fill")
                self.frontImageShadow.image = UIImage(systemName: "cloud.fill")
            } else if (description == "shower rain") {
                self.backImage.image = UIImage(named: "rain")
                self.frontImage.image = UIImage(systemName: "cloud.drizzle.fill")
                self.frontImageShadow.image = UIImage(systemName: "cloud.drizzle.fill")
            } else if (description == "rain") {
                self.backImage.image = UIImage(named: "rain")
                self.frontImage.image = UIImage(systemName: "cloud.heavyrain.fill")
                self.frontImageShadow.image = UIImage(systemName: "cloud.heavyrain.fill")
            } else if (description == "thunderstorm") {
                self.backImage.image = UIImage(named: "thunderstorm")
                self.frontImage.image = UIImage(systemName: "cloud.bolt.rain.fill")
                self.frontImageShadow.image = UIImage(systemName: "cloud.bolt.rain.fill")
            } else if (description == "snow") {
                self.backImage.image = UIImage(named: "snow")
                self.frontImage.image = UIImage(systemName: "cloud.snow.fill")
                self.frontImageShadow.image = UIImage(systemName: "cloud.snow.fill")
            } else if (description == "mist") {
                self.backImage.image = UIImage(named: "fog")
                self.frontImage.image = UIImage(systemName: "cloud.fog.fill")
                self.frontImageShadow.image = UIImage(systemName: "cloud.fog.fill")
            }
            
            let temp = weather.temp
            if (temp > 0) {
                self.labelTemperature.text = "+" + String(temp) + " C°"
            } else {
                self.labelTemperature.text = String(temp) + " C°"
            }
            
            let wind = weather.wind
            self.labelWind.text = String(wind) + " м/с"
        }
    }
    
    @IBAction func clickReload(_ sender: Any) {
        reloadWeather()
    }
    
    @IBAction func clickBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @objc func touchView() {
        showSelectLocationDialog()
    }
    
}

extension WeatherVC {
    
    private func showSelectLocationDialog() {
        
        DispatchQueue.main.async {
            
            let alert = UIAlertController(
                title: "",
                message: NSLocalizedString("weather_select_dialog_subtitle", comment: ""),
                preferredStyle: .alert)
            
            alert.addTextField{ (textField : UITextField!) -> Void in
                textField.placeholder = NSLocalizedString("city", comment: "")
            }
            
            alert.addAction(UIAlertAction(
                title: NSLocalizedString("cancel", comment: ""),
                style: .default, handler: {_ in
                    alert.dismiss(animated: true)
                }))
            
            alert.addAction(UIAlertAction(
                title: NSLocalizedString("Ок", comment: ""),
                style: .cancel, handler: {_ in
                    DispatchQueue.main.async {
                        self.labelLocation.text = alert.textFields!.first?.text?.firstUppercased
                        self.labelLocationShadow.text = alert.textFields!.first?.text?.firstUppercased
                        self.reloadWeather()
                    }
                }))
            
            self.present(alert, animated: true)
        }
        
    }
    
    private func showErrorDialog() {
        
        DispatchQueue.main.async {
            
            let alert = UIAlertController(
                title: NSLocalizedString("currency_dialog_title", comment: ""),
                message: NSLocalizedString("weather_dialog_subtitle", comment: ""),
                preferredStyle: .alert)
             
            alert.addAction(UIAlertAction(
                title: NSLocalizedString("currency_dialog_reload", comment: ""),
                style: .default, handler: {_ in
                    self.reloadWeather()
                }))
            alert.addAction(UIAlertAction(
                title: NSLocalizedString("cancel", comment: ""),
                style: .cancel, handler: {_ in
                    alert.dismiss(animated: true)
                }))
            
            self.present(alert, animated: true)
        }
        
    }
    
}

extension WeatherVC {
    
    func showSpinner() {
        DispatchQueue.main.async {
                
            self.spinner.startAnimating()
            self.spinner.isHidden = false
                
            self.viewMain.alpha = 0
                
        }
    }

    func hideSpinner() {
        DispatchQueue.main.async {
                 
            self.spinner.stopAnimating()
            self.spinner.isHidden = true
                
            self.viewMain.alpha = 1
        }
    }
        
}

