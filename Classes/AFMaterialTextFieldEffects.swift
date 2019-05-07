//
//  AFMaterialTextField.swift
//  AFMaterialTextView
//
//  Created by Ali Fakih on 5/6/19.
//  Copyright © 2019 Fakiho. All rights reserved.
//

import UIKit


open class AFMaterialTextFieldEffects: UITextField {

    public typealias AnimationCompletionHandler = (_ type: AnimationType) -> ()
    
    public let placeHolderLabel = UILabel()
    
    open func animateViewsForTextEntry() {
        fatalError("\(#function) must be overridden")
    }
    
    open func animateViewForTextDisplay() {
        fatalError("\(#function) must be overridden")
    }
    
    open var animationCompletionHanlder: AnimationCompletionHandler?
    
    open func drawViewsForRect(_ rect: CGRect) {
        fatalError("\(#function) must be overridden")
    }
    
    open func updateViewsForBoundsChange(_ bounds: CGRect) {
        fatalError("\(#function) must be overridden")
    }
    
    open override func draw(_ rect: CGRect) {
        guard isFirstResponder == false else {return}
        drawViewsForRect(rect)
    }
    
    open override func drawPlaceholder(in rect: CGRect) {
    }
    
    open override var text: String? {
        didSet {
            if let text = text, text.isNotEmpty {
                animateViewsForTextEntry()
            } else {
                animateViewForTextDisplay()
            }
        }
    }
    
    open override func willMove(toWindow newWindow: UIWindow?) {
        if newWindow != nil {
            NotificationCenter.default.addObserver(self, selector: #selector(textFieldDidEndEditing), name: NSNotification.Name.UITextFieldTextDidEndEditing, object: self)
            NotificationCenter.default.addObserver(self, selector: #selector(textFieldDidBeginEditing), name: NSNotification.Name.UITextFieldTextDidBeginEditing, object: self)
        } else {
            NotificationCenter.default.removeObserver(self)
        }
    }
    
    /**
     The textfield has started an editing session.
     */
    @objc open func textFieldDidBeginEditing() {
        animateViewsForTextEntry()
    }
    
    /**
     The textfield has ended an editing session.
     */
    @objc open func textFieldDidEndEditing() {
        animateViewForTextDisplay()
    }
    
    // MARK: - Interface Builder
    
    override open func prepareForInterfaceBuilder() {
        drawViewsForRect(frame)
    }
}
