//
//  DecimalUtil.swift
//  Bankey
//
//  Created by Alexis Horteales Espinosa on 12/05/25.
//
import Foundation

extension Decimal{
    
    var doubleValue: Double{
        return NSDecimalNumber(decimal: self).doubleValue
    }
}
