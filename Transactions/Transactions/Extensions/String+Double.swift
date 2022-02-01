//
//  String+Double.swift
//  Transactions
//
//  Created by Elvira Scablinska on 01/02/2022.
//

import Foundation

extension String {
    func convert() -> Double! {
        return (self as NSString).doubleValue
    }
}
