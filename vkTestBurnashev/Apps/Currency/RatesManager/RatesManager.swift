//
//  RatesManager.swift
//  vkTestBurnashev
//
//  Created by T BURNASHEVA on 07.09.2024.
//

import Foundation

struct GlobalRates {
    var index: String
    var rate: Double
    var preRate: Double
}

struct ErrorData: Error {
    var type: String
}

class RatesManager {
    
    func loadGlobalRates (isForcedUpdate: Bool = false, completion: @escaping (Result<[GlobalRates], Error>) -> Void) {
     
        if let url = URL(string: "https://www.cbr-xml-daily.ru/latest.js") {
            let urlSession = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
                if error != nil {
                    completion(.failure(ErrorData(type: "error")))
                } else {
                    let jsonDecoder = JSONDecoder()
                    if let data = data {
                        if let publication = try? jsonDecoder.decode(ResultCurrency.self, from: data) {
                            
                            print ("publication = \(publication)")
                            
                            var arrayGlobalRates: [GlobalRates] = []
                            arrayGlobalRates.append(GlobalRates(index: "AED", rate: publication.rates?.AED ?? 0, preRate: 0))
                            arrayGlobalRates.append(GlobalRates(index: "AMD", rate: publication.rates?.AMD ?? 0, preRate: 0))
                            arrayGlobalRates.append(GlobalRates(index: "AUD", rate: publication.rates?.AUD ?? 0, preRate: 0))
                            arrayGlobalRates.append(GlobalRates(index: "AZN", rate: publication.rates?.AZN ?? 0, preRate: 0))
                            arrayGlobalRates.append(GlobalRates(index: "BGN", rate: publication.rates?.BGN ?? 0, preRate: 0))
                            arrayGlobalRates.append(GlobalRates(index: "BRL", rate: publication.rates?.BRL ?? 0, preRate: 0))
                            arrayGlobalRates.append(GlobalRates(index: "BYN", rate: publication.rates?.BYN ?? 0, preRate: 0))
                            arrayGlobalRates.append(GlobalRates(index: "CAD", rate: publication.rates?.CAD ?? 0, preRate: 0))
                            arrayGlobalRates.append(GlobalRates(index: "CHF", rate: publication.rates?.CHF ?? 0, preRate: 0))
                            arrayGlobalRates.append(GlobalRates(index: "CNY", rate: publication.rates?.CNY ?? 0, preRate: 0))
                            arrayGlobalRates.append(GlobalRates(index: "CZK", rate: publication.rates?.CZK ?? 0, preRate: 0))
                            arrayGlobalRates.append(GlobalRates(index: "DKK", rate: publication.rates?.DKK ?? 0, preRate: 0))
                            arrayGlobalRates.append(GlobalRates(index: "EGP", rate: publication.rates?.EGP ?? 0, preRate: 0))
                            arrayGlobalRates.append(GlobalRates(index: "EUR", rate: publication.rates?.EUR ?? 0, preRate: 0))
                            arrayGlobalRates.append(GlobalRates(index: "GBP", rate: publication.rates?.GBP ?? 0, preRate: 0))
                            arrayGlobalRates.append(GlobalRates(index: "GEL", rate: publication.rates?.GEL ?? 0, preRate: 0))
                            arrayGlobalRates.append(GlobalRates(index: "HKD", rate: publication.rates?.HKD ?? 0, preRate: 0))
                            arrayGlobalRates.append(GlobalRates(index: "HUF", rate: publication.rates?.HUF ?? 0, preRate: 0))
                            arrayGlobalRates.append(GlobalRates(index: "IDR", rate: publication.rates?.IDR ?? 0, preRate: 0))
                            arrayGlobalRates.append(GlobalRates(index: "INR", rate: publication.rates?.INR ?? 0, preRate: 0))
                            arrayGlobalRates.append(GlobalRates(index: "JPY", rate: publication.rates?.JPY ?? 0, preRate: 0))
                            arrayGlobalRates.append(GlobalRates(index: "KGS", rate: publication.rates?.KGS ?? 0, preRate: 0))
                            arrayGlobalRates.append(GlobalRates(index: "KRW", rate: publication.rates?.KRW ?? 0, preRate: 0))
                            arrayGlobalRates.append(GlobalRates(index: "KZT", rate: publication.rates?.KZT ?? 0, preRate: 0))
                            arrayGlobalRates.append(GlobalRates(index: "MDL", rate: publication.rates?.MDL ?? 0, preRate: 0))
                            arrayGlobalRates.append(GlobalRates(index: "NOK", rate: publication.rates?.NOK ?? 0, preRate: 0))
                            arrayGlobalRates.append(GlobalRates(index: "NZD", rate: publication.rates?.NZD ?? 0, preRate: 0))
                            arrayGlobalRates.append(GlobalRates(index: "PLN", rate: publication.rates?.PLN ?? 0, preRate: 0))
                            arrayGlobalRates.append(GlobalRates(index: "QAR", rate: publication.rates?.QAR ?? 0, preRate: 0))
                            arrayGlobalRates.append(GlobalRates(index: "RON", rate: publication.rates?.RON ?? 0, preRate: 0))
                            arrayGlobalRates.append(GlobalRates(index: "RSD", rate: publication.rates?.RSD ?? 0, preRate: 0))
                            arrayGlobalRates.append(GlobalRates(index: "SEK", rate: publication.rates?.SEK ?? 0, preRate: 0))
                            arrayGlobalRates.append(GlobalRates(index: "SGD", rate: publication.rates?.SGD ?? 0, preRate: 0))
                            arrayGlobalRates.append(GlobalRates(index: "THB", rate: publication.rates?.THB ?? 0, preRate: 0))
                            arrayGlobalRates.append(GlobalRates(index: "TJS", rate: publication.rates?.TJS ?? 0, preRate: 0))
                            arrayGlobalRates.append(GlobalRates(index: "TMT", rate: publication.rates?.TMT ?? 0, preRate: 0))
                            arrayGlobalRates.append(GlobalRates(index: "TRY", rate: publication.rates?.TRY ?? 0, preRate: 0))
                            arrayGlobalRates.append(GlobalRates(index: "UAH", rate: publication.rates?.UAH ?? 0, preRate: 0))
                            arrayGlobalRates.append(GlobalRates(index: "USD", rate: publication.rates?.USD ?? 0, preRate: 0))
                            arrayGlobalRates.append(GlobalRates(index: "UZS", rate: publication.rates?.UZS ?? 0, preRate: 0))
                            arrayGlobalRates.append(GlobalRates(index: "VND", rate: publication.rates?.VND ?? 0, preRate: 0))
                            arrayGlobalRates.append(GlobalRates(index: "XDR", rate: publication.rates?.XDR ?? 0, preRate: 0))
                            arrayGlobalRates.append(GlobalRates(index: "ZAR", rate: publication.rates?.ZAR ?? 0, preRate: 0))
                            
                            var arrayGlobalIndex: [String] = []
                            var arrayGlobalRate: [String] = []
                            var arrayGlobalPreRate: [String] = []
                            
                            arrayGlobalRates.forEach({ item in
                                arrayGlobalIndex.append(item.index)
                                arrayGlobalRate.append(String(item.rate))
                                arrayGlobalPreRate.append(String(item.preRate))
                            })
                            
                            print ("Загружено с интернетов")
                            completion(.success(arrayGlobalRates))
                            
                        } else {
                            completion(.failure(ErrorData(type: "error")))
                        }
                    } else {
                        completion(.failure(ErrorData(type: "error")))
                    }
                }
            }
            urlSession.resume()
        } else {
            completion(.failure(ErrorData(type: "error")))
        }
        
    }
    
}
