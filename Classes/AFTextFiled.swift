//
//  AFTextFiled.swift
//  AFMaterialTextView
//
//  Created by Ali Fakih on 5/6/19.
//  Copyright © 2019 Fakiho. All rights reserved.
//

import Foundation
import UIKit

open class AFTextField : AFMaterialTextFieldEffects {
    
    /**
     The color of the border when it has no content.
     
     This property applies a color to the lower edge of the control. The default value for this property is a clear color.
     */
    @IBInspectable dynamic open var borderInactiveColor: UIColor? {
        didSet {
            updateBorder()
        }
    }
    
    /**
     The Color of the border when it has content.
     
     This property applies a color to the lower edge of the control. The default value for this property is a clear color
    */
    @IBInspectable dynamic open var borderActiveColor: UIColor? {
        didSet {
            updateBorder()
        }
    }
    /**
     The color of the placeholder text.
     
     This property applies a color to the complete placeholder string. The default value for this property is black color.
     */
    @IBInspectable dynamic open var placeHolderColor: UIColor? = .black {
        didSet {
            updatePlaceHolder()
        }
    }
    
    
    @IBInspectable open var placeholderFontScale: CGFloat = 0.65 {
        didSet {
            updatePlaceHolder()
        }
    }
    
    open override var placeholder: String? {
        didSet {
            updatePlaceHolder()
        }
    }
    
    open override var bounds: CGRect {
        didSet {
            updatePlaceHolder()
            updateBorder()
        }
    }
    
    private let borderThickness: (active: CGFloat, inactive: CGFloat) = (active: 2, inactive: 0.5)
    private let placeholderInsets = CGPoint(x: 0, y: 6)
    private let textFieldInsets = CGPoint(x: 0, y: 12)
    private let inactiveBorderLayer = CALayer()
    private let activeBorderLayer = CALayer()
    private var activePlaceHolderPoint: CGPoint = .zero
    
    
    open override func drawViewsForRect(_ rect: CGRect) {
        let frame = CGRect(origin: .zero, size: CGSize(width: rect.size.width, height: rect.size.height))
        
        placeHolderLabel.frame = frame.insetBy(dx: placeholderInsets.x, dy: placeholderInsets.y)
        
        placeHolderLabel.font = placeholderFontFromFont(font!)

        updatePlaceHolder()
        updateBorder()
        
        layer.addSublayer(inactiveBorderLayer)
        layer.addSublayer(activeBorderLayer)
        addSubview(placeHolderLabel)
    }
    
    open override func animateViewsForTextEntry() {
        if (text!.isEmpty) {
            UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.0, options: .beginFromCurrentState, animations: {
                self.placeHolderLabel.frame.origin = CGPoint(x: 10, y: self.placeHolderLabel.frame.origin.y)
            }) { _ in
                self.animationCompletionHanlder?(.textEntry)
            }
        }
        layoutPlaceholderInTextRect()
        placeHolderLabel.frame.origin = activePlaceHolderPoint
        UIView.animate(withDuration: 0.4) {
            self.placeHolderLabel.alpha = 1.0
        }
        
        activeBorderLayer.frame = rectForBorder(borderThickness.active, isFilled: true)
    }
    
    open override func animateViewForTextDisplay() {
        if (text!.isEmpty) {
            UIView.animate(withDuration: 0.35, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 2.0, options: UIView.AnimationOptions.beginFromCurrentState, animations: {
                self.layoutPlaceholderInTextRect()
                self.placeHolderLabel.alpha = 1
            }) { _ in
                self.animationCompletionHanlder?(.textDisplay)
            }
            activeBorderLayer.frame = self.rectForBorder(self.borderThickness.active, isFilled: false)
        }
    }
    
    private func updateBorder(){
        inactiveBorderLayer.frame = rectForBorder(borderThickness.inactive, isFilled: true)
        inactiveBorderLayer.backgroundColor = borderInactiveColor?.cgColor
        
        activeBorderLayer.frame = rectForBorder(borderThickness.active, isFilled: false)
        activeBorderLayer.backgroundColor = borderInactiveColor?.cgColor
        
    }
    
    private func updatePlaceHolder(){
        
        placeHolderLabel.text = placeholder
        placeHolderLabel.textColor = placeHolderColor
        placeHolderLabel.sizeToFit()
        layoutPlaceholderInTextRect()
        
        if isFirstResponder || text!.isNotEmpty {
            animateViewsForTextEntry()
        }
    }
    
    private func placeholderFontFromFont(_ font: UIFont) -> UIFont! {
        let smallerFont = UIFont(name: font.fontName, size: font.pointSize * placeholderFontScale)
        return smallerFont
    }
    
    private func rectForBorder(_ thickness: CGFloat, isFilled: Bool) -> CGRect {
        if isFilled {
            return CGRect(origin: CGPoint(x: 0, y: frame.height - thickness), size: CGSize(width: frame.width, height: thickness))
        } else {
            return CGRect(origin: CGPoint(x: 0, y: frame.height - thickness), size: CGSize(width: 0, height: thickness))
        }
    }
    
    private func layoutPlaceholderInTextRect() {
        let textRect = self.textRect(forBounds: bounds)
        var originX = textRect.origin.x
        switch self.textAlignment {
        case .center:
            originX += textRect.size.width / 2 - placeHolderLabel.bounds.width / 2
        case .right:
            originX += textRect.size.width - placeHolderLabel.bounds.width
        default:
            break
        }
        placeHolderLabel.frame = CGRect(x: originX, y: textRect.height / 2, width: placeHolderLabel.bounds.width, height: placeHolderLabel.bounds.height)
        activePlaceHolderPoint = CGPoint(x: placeHolderLabel.frame.origin.x, y: placeHolderLabel.frame.origin.y - placeHolderLabel.frame.size.height - placeholderInsets.y)
    }
    
    open override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.offsetBy(dx: textFieldInsets.x, dy: textFieldInsets.y)
    }
    
    open override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.offsetBy(dx: textFieldInsets.x, dy: textFieldInsets.y)
    }
}

