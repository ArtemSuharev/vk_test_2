//
//  WeatherManager.swift
//  vkTestBurnashev
//
//  Created by T BURNASHEVA on 07.09.2024.
//

import Foundation

class WeatherManager {
    
    private let API_KEY = "7ae17ff96002a53fefe7ce8e58d711dd"
    
    func loadWeather(city: String, completion: @escaping (Result<WeatherList, Error>) -> Void) {

        print("loadWeather")
        
        let url = URL(string:"https://api.openweathermap.org/data/2.5/weather?q=" + city + "&appid=" + API_KEY)!
        //let url = URL(string:"https://samples.openweathermap.org/data/2.5/history/city?id=2885679&type=hour&appid=b1b15e88fa797225412429c1c50c122a1")!
        URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) in
            
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(ErrorData(type: "error")))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse,
                    (200...299).contains(httpResponse.statusCode) else {
                        print("Error with the response, unexpected status code: \(String(describing: response))")
                        completion(.failure(ErrorData(type: "error")))
                        return
                }

            guard let data = data else {
                print("error data")
                completion(.failure(ErrorData(type: "error")))
                return
            }
            
            guard let dictionaryObj = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                print("error dictionaryObj")
                completion(.failure(ErrorData(type: "error")))
                return
            }
            
            
            let first = dictionaryObj.first
            
            print("dictionaryObj = ", dictionaryObj)
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
                    print("weather 1 = ", valueArray)
                    let value = valueArray?.first as? [String: Any]
                    print("weather 2 = ", value)
                    description = value?["description"] as? String ?? "clear sky"
                }
            }
            
            var result : WeatherList = WeatherList(
                temp: temp,
                description: description,
                wind: wind
            )
            
            completion(.success(result))
            
//            if let first = list.first, let wind = first["wind"] {
//                print(wind)
//            }
        }).resume()
        
    }
    
}
