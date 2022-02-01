//
//  TransactionManager.swift
//  Transactions
//
//  Created by Elvira Scablinska on 27/01/2022.
//

import Foundation

class TransactionManager {
    weak var delegate: DataLoadingDelegate?
    
    static let shared = TransactionManager()
    
    func fetchData() {
        NetworkManager().retrieveData(url: Defines.baseURL) { failed, data in
            if (failed || data == nil) {
                self.dataLoadingFailed()
            }else {
                self.decodeData(data)
            }
        }
    }
    
    func dataLoadingFailed() {
        delegate?.fetchFailed()
    }
    
    func decodeData(_ data: Data?) {
        let decoder = JSONDecoder()
        do {
            let transactions = try decoder.decode([TransactionDTO].self, from: data!)
            for transaction in transactions {
                DispatchQueue.main.async {
                    Database.shared.saveTransaction(transaction)
                }
            }
            delegate?.updateSucceeded()
            
        } catch {
            print("Error info: \(error)")
            dataLoadingFailed()
        }
    }
}
