//
//  PasswordRule.swift
//  AFMaterialTextView
//
//  Created by Ali Fakih on 5/6/19.
//  Copyright © 2019 Fakiho. All rights reserved.
//

import Foundation
open class PasswordRule: RegexRule {
    
    static let regex = "^(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[a-z]).{8,}$"
    public convenience init(message: String = "Your password must be at least 8 charachters long and contain one uppercase letter and one number") {
        self.init(regex: PasswordRule.regex, errorMessage: message)
    }
    
}
