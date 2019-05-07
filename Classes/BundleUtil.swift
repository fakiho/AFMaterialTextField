//
//  BundleUtil.swift
//  AFMaterialTextView
//
//  Created by Ali Fakih on 5/6/19.
//  Copyright © 2019 Fakiho. All rights reserved.
//

import Foundation
open class BundleUtil:NSObject{
    
    
    /// Gets the bundle property for the pod
    public static var bundle:Bundle{
        
        get{
            
            //Get the bundle
            var bundle = Bundle(for: self.classForCoder())
            
            //Trys to load the path to resource(In case we are calling this from the pod)
            if let bundlePath:String = bundle.path(forResource: "PasswordTextField", ofType: "bundle")
            {
                //If we get the path to resource, set the bundle path
                bundle =  Bundle(path: bundlePath)!
                
            }
            
            return bundle
        }
    }
    
    
}
