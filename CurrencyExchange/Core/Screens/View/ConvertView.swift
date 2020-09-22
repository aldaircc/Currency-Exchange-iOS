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

class ConvertView: UIViewController {
    
    //MARK:- UI Properties
    let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
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
    
    let currencyFromPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        return pickerView
    }()
    
    let toCurrencyPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        return pickerView
    }()
    
    let convertButton: UIButton = {
        let button = UIButton()
        button.setTitle("Convert", for: .normal)
        return button
    }()
    
    //MARK:- Properties local
    let service = ConvertService()
    var viewModel: ConvertViewModel!
    let disposeBag = DisposeBag()
    let compositeDisposable = CompositeDisposable()
    
    //MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ConvertViewModel(service: self.service)
        setupUI()
        setupActions()
        // Do any additional setup after loading the view.
        let service = ConvertService()
        service.demo()
        
//        Observable.just(["Item 01", "Item 02", "Item 03"])
//            .bind(to: self.currencyFromPickerView.rx.itemTitles{ _, item in
//                return "\(item)"
//            })
        
        Observable.just(["Item 1","Item 2", "etc"])
                            .bind(to: currencyFromPickerView.rx.itemTitles) { _, item in
                                return item
        }.disposed(by: disposeBag)

        self.currencyFromPickerView.rx.itemSelected.asObservable().subscribe(onNext: { item in
            print("Item selected \(item)")
            }).disposed(by: disposeBag)

        self.currencyFromPickerView.selectRow(1, inComponent: 0, animated: true)
    }
    
    //MARK:- Methods
    func setupUI(){
        self.view.backgroundColor = .green
        self.view.addSubview(contentStackView)
        self.contentStackView.insertArrangedSubview(titleLabel, at: 0)
        self.contentStackView.insertArrangedSubview(currencyFromPickerView, at: 1)
        self.contentStackView.insertArrangedSubview(amountTextField, at: 2)
        self.contentStackView.insertArrangedSubview(toCurrencyPickerView, at: 3)
        self.contentStackView.insertArrangedSubview(convertButton, at: 4)
        
        self.contentStackView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.top.equalToSuperview().offset(10.0)
            make.bottom.equalToSuperview().offset(-20.0)
        }
    }
    
    func setupActions(){
        self.convertButton.rx.tap.bind {
            self.viewModel.getConvertCurrency(from: "USD_PHP", to: "PHP_USD", for: 10)
        }.disposed(by: disposeBag)
    }
    
    func clear(){
        self.compositeDisposable.dispose()
    }
    
}
