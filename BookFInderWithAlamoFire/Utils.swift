//
//  Utils.swift
//  BookFInderWithAlamoFire
//
//  Created by yuri on 2022/11/03.
//

import Foundation

func numberFormatter(number: Int) -> String {
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .decimal
    
    return numberFormatter.string(from: NSNumber(value: number))!
}
