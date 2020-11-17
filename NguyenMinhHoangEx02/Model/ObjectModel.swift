//
//  ObjectModel.swift
//  NguyenMinhHoangEx02
//
//  Created by Hoang on 11/14/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import Foundation
import ObjectMapper
class Person: Mappable {
    init() {
    }
    var name: String = "ABC"
    var time: String = ""
    var money: String = ""
    var content: String = ""
    required init?(map: Map) {
    }
    func mapping(map: Map) {
        name <- map["name"]
        time <- map["time"]
        money <- map["money"]
        content <- map["content"]
    }
}
class Debtors: Mappable {
    var dangChoVay: [Person] = []
    required init?(map: Map) {
    }
    func mapping(map: Map) {
        dangChoVay <- map["dangChoVay"]
    }
}
class Creditors: Mappable {
    var dangVay: [Person] = []
    required init?(map: Map) {
    }
    func mapping(map: Map) {
        dangVay <- map["dangVay"]
    }
}
