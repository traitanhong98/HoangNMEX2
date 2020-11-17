//
//  DataModel.swift
//  NguyenMinhHoangEx02
//
//  Created by Hoang on 11/14/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class DataModel {
    static let shared = DataModel()
    let requestModel = RequestModel()
    
    var listDebtors: BehaviorRelay<[Person]> = BehaviorRelay(value: [])
    var listCreditor: BehaviorRelay<[Person]> = BehaviorRelay(value: [])
    func getListDebts() {
        requestModel.getData(withEndPoint: "getDangChoVay") { (status, debtors: Debtors?) in
            if status,
                let listDebtors = debtors {
                self.listCreditor.accept(listDebtors.dangChoVay)
            }
        }
    }
    func getListCredistor() {
        requestModel.getData(withEndPoint: "dangVay") { (status, debtors: Creditors?) in
            if status,
                let listDebtors = debtors {
                self.listDebtors.accept(listDebtors.dangVay)
            }
        }
    }
}
