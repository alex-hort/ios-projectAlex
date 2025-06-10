//
//  PasswordCriteria.swift
//  Password
//
//  Created by Alexis Horteales Espinosa on 10/06/25.
//

import Foundation

struct PasswordCriteria{
    static func lenghtCriteriaMet(_ text: String) -> Bool{
        text.count >= 8 && text.count <= 32
    }
    static func noSpaceCriteriaMet(_ text: String) -> Bool{
        text.rangeOfCharacter(from: NSCharacterSet.whitespaces) == nil
    }
    static func lenghtAndNoSpaceMet(_ text: String) -> Bool{
        lenghtCriteriaMet(text) && noSpaceCriteriaMet(text)
    }
}
