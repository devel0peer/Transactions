//
//  ErrorLabel.swift
//  Transactions
//
//  Created by Elvira Scablinska on 31/01/2022.
//

import UIKit

class ErrorLabel: UILabel {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        textColor = UIColor.red
    }
}
