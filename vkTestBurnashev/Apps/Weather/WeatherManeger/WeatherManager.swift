//
//  WeatherManager.swift
//  vkTestBurnashev
//
//  Created by T BURNASHEVA on 07.09.2024.
//

import Foundation

class WeatherManager {
    
    private let API_KEY = "feeb64129bc41bfbe932f484af08fdd5"
    
    func loadWeather(city: String, completion: @escaping (Result<WeatherList, Error>) -> Void) {

        let url = URL(string:"https://api.openweathermap.org/data/2.5/weather?q=" + city + "&appid=" + API_KEY)!
        URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) in
            
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(ErrorData(type: "error")))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse,
                    (200...299).contains(httpResponse.statusCode) else {
                        completion(.failure(ErrorData(type: "error")))
                        return
                }

            guard let data = data else {
                completion(.failure(ErrorData(type: "error")))
                return
            }
            
            guard let dictionaryObj = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                completion(.failure(ErrorData(type: "error")))
                return
            }
            
            
            let first = dictionaryObj.first
            
            var temp: Int = 0
            var wind: Int = 0
            var description: String = ""
            
            dictionaryObj.forEach { item in
                if item.key == "main" {
                    let value = item.value as? [String: Double]
                    let t: Double = (value!["temp"] ?? 300) - 273
                    temp = Int(t)
                }
                if item.key == "wind" {
                    let value = item.value as? [String: Double]
                    let w: Double = value!["speed"] ?? 0
                    wind = Int(w)
                }
                if item.key == "weather" {
                    let valueArray = item.value as? [Any]
                    let value = valueArray?.first as? [String: Any]
                    description = value?["description"] as? String ?? "clear sky"
                }
            }
            
            var result : WeatherList = WeatherList(
                temp: temp,
                description: description,
                wind: wind
            )
            
            completion(.success(result))
            
        }).resume()
        
    }
    
}
