//
//  Transaction.swift
//  Transactions
//
//  Created by Elvira Scablinska on 27/01/2022.
//

import Foundation

class TransactionDTO : Codable {
    var id: String
    var counterPartyName: String
    var counterPartyAccount: String
    var type: String
    var amount: String
    var description: String
    var date: String
}
