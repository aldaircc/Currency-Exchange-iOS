//
//  ConvertorService.swift
//  CurrencyExchange
//
//  Created by Aldair Raul Cosetito Coral on 9/14/20.
//  Copyright © 2020 Aldair Cosetito. All rights reserved.
//

import Foundation

struct ComplexObject: Decodable {
    let timestamp: Int
    let identifier: String
}

extension ComplexObject {
    enum CodingKeysC: String, CodingKey {
        case timestamp
        case identifier
    }
}

enum DecodingError: Error {
    case corruptedData
}


struct ConvertService: RestAPI {
    
    func demo() {
        
        let json = """
            {
            "USD_PHP":48.485039,
            "PHP_USD":0.020625
            }
            """
        
        do {
            let data = Data(json.utf8)
            print("\(json)")
            
            let decoder = JSONDecoder()
            let decodeObject = try decoder.decode(currencyConversion.self, from: data)
            
            print(decodeObject)

        } catch (let exception) {
            print(exception.localizedDescription)
        }
        
    }
}


struct currencyConversion: Decodable{
    var response: [ExchangeRate]
    
    private struct DynamicCodingKeys: CodingKey{
        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        
        var intValue: Int?
        init?(intValue: Int) {
            return nil
        }
    }
    
    init(from decoder: Decoder) throws{
//        let container = try decoder.container(keyedBy: DynamicCodingKeys.self)
//        var tempArray = [ExchangeRate]()
//
//        for key in container.allKeys {
//            print("\(key)")
//            let decodedObject = try container.decode(ExchangeRate.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
//            tempArray.append(decodedObject)
//        }
        
        let values: [ExchangeRate]
        let container = try decoder.singleValueContainer()
        let dictionary = try container.decode([String: Double].self)
        
        values = dictionary.map{ key, value in
            ExchangeRate(currency: key, rate: value)
        }
        
        response = values
//        array = tempArray
    }
}



struct ExchangeRate: Decodable {
    let currency: String //Currency
    let rate: Double
}

private extension ExchangeRate{
    struct List: Decodable {
        let values: [ExchangeRate]
        
        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            let dictionary = try container.decode([String: Double].self)
            
            values = dictionary.map{ key,value in
                ExchangeRate(currency: key, rate: value)
            }
        }
    }
}

//

class resultAPICountry: Codable{
    
    enum CodingKeys: String, CodingKey {
        case results = "results"
    }
    
    let results: [String: Currency]?
}

class Currency: Codable {
    
    enum CodingKeys: String, CodingKey{
        case currencyId = "currencyId"
        case currencyName = "currencyName"
        case currencySymbol = "currencySymbol"
        case id = "id"
    }
    //test
    let currencyId: String?
    let currencyName: String?
    let currencySymbol: String?
    let id: String?
}







// let url = "https://free.currconv.com/api/v7/currencies?apiKey=cdb7a9483e3f8baf3e6c"
//    //"https://free.currconv.com/api/v7/countries?apiKey=cdb7a9483e3f8baf3e6c"
//
//    func getCurrencies(completion: @escaping(responseAPI<[Currency]>) -> Void) {
//        callService(from: url, verb: "GET", objectType: resultAPICountry.self) { (response) in
//            switch response {
//            case .failure(let error):
//                print("Error \(error.localizedDescription)")
//            case .success(let data):
//                print("Data: \(data)")
//
//                guard let peruvianData = data.results else { return }
//                print("Peruvian DATA")
//                print(peruvianData["PEN"]!)
//
//            }
//        }
//    }
//
//    //https://free.currconv.com/api/v7/convert?q=USD_PEN&compact=ultra&apiKey=cdb7a9483e3f8baf3e6c
//    func getConvertResult(completion: @escaping((responseAPI<String>) -> Void)) {
//        let url = "\(API.baseURL)\(API.EndPoints.convert)?q=USD_PHP,PHP_USD&compact=ultra&apiKey=\(API.apiKey)"
////        callService(from: url, verb: "GET", objectType: DecodedArray.self) { (response) in
////            switch response {
////            case .failure(let error):
////                print("\(error.localizedDescription)")
////            case .success(let data):
////                print(data)
////            }
////        }
//        ///api/v7/convert?q=USD_PHP,PHP_USD&compact=ultra&apiKey=[YOUR_API_KEY]
//
//
//    }
