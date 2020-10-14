//
//  ConvertView.swift
//  CurrencyExchange
//
//  Created by Aldair Raul Cosetito Coral on 9/14/20.
//  Copyright © 2020 Aldair Cosetito. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class ConvertView: UIViewController{
    
    //MARK:- UI Properties
    let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 1
        return stackView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Exchange currency from code"
        label.baselineAdjustment = .alignCenters
        label.textAlignment = .center
        return label
    }()
    
    let amountTextField: UITextField = {
        let textfield = UITextField()
        textfield.text = "369"
        return textfield
    }()
    
    let fromLabel: UILabel = {
        let label = UILabel()
        label.text = "From"
        return label
    }()
    
    let toLabel: UILabel = {
        let label = UILabel()
        label.text = "To"
        return label
    }()
    
    let fromCurrencyPicker: UIPickerView = {
        let pickerView = UIPickerView()
        return pickerView
    }()
    
    let toCurrencyPicker: UIPickerView = {
        let pickerView = UIPickerView()
        return pickerView
    }()
    
    let convertButton: UIButton = {
        let button = UIButton()
        button.setTitle("Convert", for: .normal)
        button.backgroundColor = .blue
        return button
    }()
    
    //MARK:- Properties local
    let convertService = ConvertService()
    let countryService = CountryService()
    var convertViewModel: ConvertViewModel!
    var countryViewModel: CountryViewModel!
    let disposeBag = DisposeBag()
    let compositeDisposable = CompositeDisposable()
    
    var currencyArray = [String]()
    var countryArray = [Country]()
    
    //MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        convertViewModel = ConvertViewModel(service: self.convertService)
        countryViewModel = CountryViewModel(service: self.countryService)
        setupUI()
        setupActions()
        
        
        self.countryViewModel.getCountries().observeOn(MainScheduler.asyncInstance)
            .subscribe(onNext: { response in
                
                for item in response.results{
                    self.currencyArray.append(item.value.currencyName)
                    self.countryArray.append(Country.init(alpha3: item.value.alpha3,
                                                          currencyId: item.value.currencyId,
                                                          currencyName: item.value.currencyName,
                                                          currencySymbol: item.value.currencySymbol,
                                                          name: item.value.name))
                }
                
                Observable.just(self.currencyArray)
                    .bind(to: self.fromCurrencyPicker.rx.itemTitles){ _, item in
                        return "\(item)"
                    }.disposed(by: self.disposeBag)
                
                Observable.just(self.currencyArray)
                    .bind(to: self.toCurrencyPicker.rx.itemTitles){ _, item in
                        return "\(item)"
                    }.disposed(by: self.disposeBag)
                
            }, onError: { error in
                
            }, onCompleted: {
                
            }, onDisposed: {
                
            })
            .disposed(by: self.disposeBag)
    }
    
    //MARK:- Methods
    func setupUI(){
        self.view.addSubview(contentStackView)
        self.contentStackView.insertArrangedSubview(titleLabel, at: 0)
        self.contentStackView.insertArrangedSubview(fromLabel, at: 1)
        self.contentStackView.insertArrangedSubview(fromCurrencyPicker, at: 2)
        self.contentStackView.insertArrangedSubview(amountTextField, at: 3)
        self.contentStackView.insertArrangedSubview(toLabel, at: 4)
        self.contentStackView.insertArrangedSubview(toCurrencyPicker, at: 5)
        self.contentStackView.insertArrangedSubview(convertButton, at: 6)
        
        self.contentStackView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.top.equalToSuperview().offset(10.0)
            make.bottom.equalToSuperview().offset(-20.0)
        }
    }
    
    func setupActions(){
        //        self.currencyFromPickerView.dataSource = self
        //        self.currencyFromPickerView.delegate = self
        //        self.toCurrencyPickerView.dataSource = self
        //        self.toCurrencyPickerView.delegate = self
        
        self.fromCurrencyPicker.rx.modelSelected(String.self)
            .map{ item in
                item.first
            }
            .bind(to: self.fromLabel.rx.text)
            .disposed(by: self.disposeBag)
        
        self.toCurrencyPicker.rx.modelSelected(String.self)
            .map{ item in
                item.first
            }
            .bind(to: self.toLabel.rx.text)
            .disposed(by: self.disposeBag)
        
        self.convertButton.rx.tap.bind {
            
            self.convertViewModel.getConvertCurrency(currency: self.makeFormatCurrency(from: self.fromLabel.text!, to: self.toLabel.text!), // "USD_PEN",
                                                     to: self.makeFormatCurrency(from: self.toLabel.text!, to: self.fromLabel.text!), //"PEN_USD",
                                                     for: 2)
                .observeOn(MainScheduler.asyncInstance)
                .subscribe(onNext: { response in
                    print("Response \(response)")
                },
                onError: { error in
                    print("Error \(error.localizedDescription)")
                },
                onCompleted: {
                    print("On Completed convert currency")
                },
                onDisposed: {
                    print("On dispose")
                })
                .disposed(by: self.disposeBag)
            
        }.disposed(by: disposeBag)
    }
    
    func clear(){
        self.compositeDisposable.dispose()
    }
    
    func makeFormatCurrency(from: String, to: String) -> String {
        
        let filter = self.countryArray.filter { $0.currencyName == from }
        
        return filter.description
//        guard let fromCode = self.countryArray.filter else { return ""}
//
//        guard let toCode = self.countryArray[0] else { return ""}
//
//        return "\(fromCode)_\(toCode)"
    }
}

extension ConvertView: UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let title = self.currencyArray[row]
        return title
    }
}
