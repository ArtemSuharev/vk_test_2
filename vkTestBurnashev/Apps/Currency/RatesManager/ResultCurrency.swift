//
//  ResultCurrency.swift
//  vkTestBurnashev
//
//  Created by T BURNASHEVA on 07.09.2024.
//

import Foundation

struct ResultCurrency : Codable {
    
    var disclaimer : String?
    var date : String?
    var timestamp : Int?
    var base : String?
    var rates : ResultCurrencyRates?

    enum CodingKeys: String, CodingKey {
        case disclaimer = "disclaimer"
        case date = "date"
        case timestamp = "timestamp"
        case base = "base"
        case rates = "rates"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        disclaimer = try values.decodeIfPresent(String.self, forKey: .disclaimer)
        date = try values.decodeIfPresent(String.self, forKey: .date)
        timestamp = try values.decodeIfPresent(Int.self, forKey: .timestamp)
        base = try values.decodeIfPresent(String.self, forKey: .base)
        rates = try values.decodeIfPresent(ResultCurrencyRates.self, forKey: .rates)
        
    }
    
    init() {
        
    }

}

struct ResultCurrencyRates : Codable {
    
    var AUD : Double?
    var AZN : Double?
    var GBP : Double?
    var AMD : Double?
    var BYN : Double?
    var BGN : Double?
    var BRL : Double?
    var HUF : Double?
    var VND : Double?
    var HKD : Double?
    var GEL : Double?
    var DKK : Double?
    var AED : Double?
    var USD : Double?
    var EUR : Double?
    var EGP : Double?
    var INR : Double?
    var IDR : Double?
    var KZT : Double?
    var CAD : Double?
    var QAR : Double?
    var KGS : Double?
    var CNY : Double?
    var MDL : Double?
    var NZD : Double?
    var NOK : Double?
    var PLN : Double?
    var RON : Double?
    var XDR : Double?
    var SGD : Double?
    var TJS : Double?
    var THB : Double?
    var TRY : Double?
    var TMT : Double?
    var UZS : Double?
    var UAH : Double?
    var CZK : Double?
    var SEK : Double?
    var CHF : Double?
    var RSD : Double?
    var ZAR : Double?
    var KRW : Double?
    var JPY : Double?

    enum CodingKeys: String, CodingKey {
        case AUD = "AUD"
        case AZN = "AZN"
        case GBP = "GBP"
        case AMD = "AMD"
        case BYN = "BYN"
        case BGN = "BGN"
        case BRL = "BRL"
        case HUF = "HUF"
        case VND = "VND"
        case HKD = "HKD"
        case GEL = "GEL"
        case DKK = "DKK"
        case AED = "AED"
        case USD = "USD"
        case EUR = "EUR"
        case EGP = "EGP"
        case INR = "INR"
        case IDR = "IDR"
        case KZT = "KZT"
        case CAD = "CAD"
        case QAR = "QAR"
        case KGS = "KGS"
        case CNY = "CNY"
        case MDL = "MDL"
        case NZD = "NZD"
        case NOK = "NOK"
        case PLN = "PLN"
        case RON = "RON"
        case XDR = "XDR"
        case SGD = "SGD"
        case TJS = "TJS"
        case THB = "THB"
        case TRY = "TRY"
        case TMT = "TMT"
        case UZS = "UZS"
        case UAH = "UAH"
        case CZK = "CZK"
        case SEK = "SEK"
        case CHF = "CHF"
        case RSD = "RSD"
        case ZAR = "ZAR"
        case KRW = "KRW"
        case JPY = "JPY"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        AUD = try values.decodeIfPresent(Double.self, forKey: .AUD)
        AZN = try values.decodeIfPresent(Double.self, forKey: .AZN)
        GBP = try values.decodeIfPresent(Double.self, forKey: .GBP)
        AMD = try values.decodeIfPresent(Double.self, forKey: .AMD)
        BYN = try values.decodeIfPresent(Double.self, forKey: .BYN)
        BGN = try values.decodeIfPresent(Double.self, forKey: .BGN)
        BRL = try values.decodeIfPresent(Double.self, forKey: .BRL)
        HUF = try values.decodeIfPresent(Double.self, forKey: .HUF)
        VND = try values.decodeIfPresent(Double.self, forKey: .VND)
        HKD = try values.decodeIfPresent(Double.self, forKey: .HKD)
        GEL = try values.decodeIfPresent(Double.self, forKey: .GEL)
        DKK = try values.decodeIfPresent(Double.self, forKey: .DKK)
        AED = try values.decodeIfPresent(Double.self, forKey: .AED)
        USD = try values.decodeIfPresent(Double.self, forKey: .USD)
        EUR = try values.decodeIfPresent(Double.self, forKey: .EUR)
        EGP = try values.decodeIfPresent(Double.self, forKey: .EGP)
        INR = try values.decodeIfPresent(Double.self, forKey: .INR)
        IDR = try values.decodeIfPresent(Double.self, forKey: .IDR)
        KZT = try values.decodeIfPresent(Double.self, forKey: .KZT)
        CAD = try values.decodeIfPresent(Double.self, forKey: .CAD)
        QAR = try values.decodeIfPresent(Double.self, forKey: .QAR)
        KGS = try values.decodeIfPresent(Double.self, forKey: .KGS)
        CNY = try values.decodeIfPresent(Double.self, forKey: .CNY)
        MDL = try values.decodeIfPresent(Double.self, forKey: .MDL)
        NZD = try values.decodeIfPresent(Double.self, forKey: .NZD)
        NOK = try values.decodeIfPresent(Double.self, forKey: .NOK)
        PLN = try values.decodeIfPresent(Double.self, forKey: .PLN)
        RON = try values.decodeIfPresent(Double.self, forKey: .RON)
        XDR = try values.decodeIfPresent(Double.self, forKey: .XDR)
        SGD = try values.decodeIfPresent(Double.self, forKey: .SGD)
        TJS = try values.decodeIfPresent(Double.self, forKey: .TJS)
        THB = try values.decodeIfPresent(Double.self, forKey: .THB)
        TRY = try values.decodeIfPresent(Double.self, forKey: .TRY)
        TMT = try values.decodeIfPresent(Double.self, forKey: .TMT)
        UZS = try values.decodeIfPresent(Double.self, forKey: .UZS)
        UAH = try values.decodeIfPresent(Double.self, forKey: .UAH)
        CZK = try values.decodeIfPresent(Double.self, forKey: .CZK)
        SEK = try values.decodeIfPresent(Double.self, forKey: .SEK)
        CHF = try values.decodeIfPresent(Double.self, forKey: .CHF)
        RSD = try values.decodeIfPresent(Double.self, forKey: .RSD)
        ZAR = try values.decodeIfPresent(Double.self, forKey: .ZAR)
        KRW = try values.decodeIfPresent(Double.self, forKey: .KRW)
        JPY = try values.decodeIfPresent(Double.self, forKey: .JPY)
    }
    
    init() {
        
    }

}
