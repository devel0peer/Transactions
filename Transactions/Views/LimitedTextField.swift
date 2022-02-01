//
//  LimitedTextField.swift
//  Transactions
//
//  Created by Elvira Scablinska on 31/01/2022.
//

import UIKit

class LimitedTextField: UITextField {
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if (action == paste || action == selectAll || action == cut) {
            return false
        }
        return super.canPerformAction(action, withSender: sender)
    }
    
    var paste: Selector = #selector(UIResponderStandardEditActions.paste(_:))
    var selectAll: Selector = #selector(UIResponderStandardEditActions.selectAll(_:))
    var cut: Selector = #selector(UIResponderStandardEditActions.cut(_:))
    
    override public var text: String! {
        get {
            return super.text ?? ""
        }set {
            super.text = newValue
        }
    }
}
