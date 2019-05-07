//
//  FieldType.swift
//  AFMaterialTextView
//
//  Created by Ali Fakih on 5/6/19.
//  Copyright © 2019 Fakiho. All rights reserved.
//

import Foundation
public enum FieldType: Int {
    case Default
    case Email
    case Passwrod
    
    public func fieldTypeRaw() -> String {
        var fieldType: String = "Default"
        switch self {
        case .Default:
            fieldType = "Default"
        case .Email:
            fieldType = "Email"
        case .Passwrod:
            fieldType = "Password"
        }
        return fieldType
    }
    
    public init() {
        self = .Default
    }
    
    public init(value: Int) {
        var result: FieldType = FieldType()
        switch value {
        case FieldType.Default.rawValue:
            result = FieldType.Default
        case FieldType.Email.rawValue:
            result = FieldType.Email
        case FieldType.Passwrod.rawValue:
            result = FieldType.Passwrod
        default:
            result = FieldType.Default
        }
        self = result
    }
        
}
