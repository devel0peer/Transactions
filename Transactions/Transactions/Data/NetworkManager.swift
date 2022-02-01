//
//  NetworkManager.swift
//  Transactions
//
//  Created by Elvira Scablinska on 27/01/2022.
//

import Foundation

class NetworkManager {
    func retrieveData(url: String, finished: @escaping (Bool, Data?) -> Void) {
        let url = URL(string: url)
        guard url != nil else {
            return
        }

        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            finished(error != nil, data)
        }
        dataTask.resume()
    }
}
