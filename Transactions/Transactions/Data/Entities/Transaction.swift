//
//  Transaction.swift
//  Transactions
//
//  Created by Elvira Scablinska on 27/01/2022.
//

import Foundation
import CoreData

class Transaction : NSManagedObject {
    
    class func find(id: String, in context: NSManagedObjectContext) throws -> Transaction? {
        let request: NSFetchRequest<Transaction> = Transaction.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id)

        do {
            let matches = try context.fetch(request)
            if (matches.count > 0) {
                return matches[0]
            }
        }catch {
            throw error
        }

        return nil
    }
    
    class func mergeData(_ transaction: Transaction, _ transactionDTO: TransactionDTO) -> Transaction {
        transaction.counterPartyName = transactionDTO.counterPartyName
        transaction.counterPartyAccount = transactionDTO.counterPartyAccount
        transaction.type = transactionDTO.type
        transaction.amount = transactionDTO.amount
        transaction.description_ = transactionDTO.description
        transaction.date = transactionDTO.date
        return transaction
    }
    
    class func update(transaction: Transaction, transactionDTO: TransactionDTO, in context: NSManagedObjectContext) {
        _ = mergeData(transaction, transactionDTO)
        try? context.save()
    }
    
    class func create(_ id: String, _ transactionDTO: TransactionDTO, in context: NSManagedObjectContext) -> Transaction {
        let transaction = Transaction(context: context)
        transaction.id = transactionDTO.id
        _ = mergeData(transaction, transactionDTO)
        try? context.save()
        return transaction
    }
}
