//
//  RegexRule.swift
//  AFMaterialTextView
//
//  Created by Ali Fakih on 5/6/19.
//  Copyright © 2019 Fakiho. All rights reserved.
//

import Foundation
/**
    *  Protocol that represent something that conforms to a Rule
*/
public protocol Ruleable {
    func validate(_ value: String) -> Bool
    func errorMessage() -> String
}

open class RegexRule: Ruleable {
    
    fileprivate var REGEX: String = "^(?=.*?[A-Z]).{8,}$"
    fileprivate var message: String
    
    init(regex: String, errorMessage: String = "Invalid Regular Expression") {
        self.REGEX = regex
        self.message = errorMessage
    }
    
    public func validate(_ value: String) -> Bool {
        let test = NSPredicate(format: "SELF MATCHES %@", self.REGEX)
        return test.evaluate(with: value)
    }
    
    public func errorMessage() -> String {
        return message
    }
    
    
}
