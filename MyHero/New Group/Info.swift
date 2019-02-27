//
//  Data.swift
//  MyHero
//
//  Created by Zhuguang Jiang on 2/25/19.
//  Copyright © 2019 Zhuguang Jiang. All rights reserved.
//

import Foundation

class Info: Codable {
    
    var heath : Int = 100
    var attack : Int = 10
    var agile : Double = 1.0
    var strength : Double = 1.0
    var level : Int = 1
    var chance : Int = 5
    var crit : Double = 0.0
    var selected_Item = Equipment()
    var gold : Int = 0
    var numbers : [Int] = []
    var equ : [Equipment] = []
}


