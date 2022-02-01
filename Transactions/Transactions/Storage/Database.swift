//
//  Database.swift
//  Transactions
//
//  Created by Elvira Scablinska on 27/01/2022.
//

import Foundation
import CoreData
import UIKit

class Database {
    static let shared = Database()
    
    var container: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    
    func saveTransaction(_ transaction: TransactionDTO) {
        if let context = container?.viewContext {
            if let savedTransaction = try? Transaction.find(id: transaction.id, in: context) {
                Transaction.update(transaction: savedTransaction, transactionDTO: transaction, in: context)
            }else {
                _ = Transaction.create(transaction.id, transaction, in: context)
            }
        }
    }
    
    func findAllTransactions() -> [Transaction] {
        if let context = container?.viewContext {
            let request: NSFetchRequest<Transaction> = Transaction.fetchRequest()
            if let owners = (try? context.fetch(request)) {
                return owners
            }
        }
        return [Transaction]()
    }
    
    func sumTotal() -> Double {
        var sum: Double = 0
        let all = findAllTransactions()
        for transaction in all {
            sum = sum + (transaction.amount?.convert() ?? 0)
        }
        return sum
    }
}
