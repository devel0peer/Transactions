//
//  DataLoadingDelegate.swift
//  Transactions
//
//  Created by Elvira Scablinska on 27/01/2022.
//

import Foundation

protocol DataLoadingDelegate : AnyObject {
    func fetchFailed()
    func updateSucceeded()
}
