//
//  CountryService.swift
//  CurrencyExchange
//
//  Created by Aldair Raul Cosetito Coral on 9/26/20.
//  Copyright © 2020 Aldair Cosetito. All rights reserved.
//

import Foundation
import RxSwift

struct CountryService: RestAPI {
    
    let url = API.baseURL
        + API.EndPoints.countries.rawValue
        + "?apiKey="+API.apiKey
    
    func getCountries() -> Observable<ResultCountry>{
        let observable = Observable<ResultCountry>
            .create { observer in
                
                callService(from: url,
                            method: .GET,
                            objectType: ResultCountry.self) { response in
                    switch response{
                    case .failure(let error):
                        observer.onError(error)
                    case .success(let data):
                        observer.onNext(data)
                        observer.onCompleted()
                    }
                }
                return Disposables.create()
            }
        return observable
    }
}
