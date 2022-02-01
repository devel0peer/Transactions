//
//  Keychain.swift
//  Transactions
//
//  Created by Elvira Scablinska on 31/01/2022.
//

import Foundation

class Keychain {
    class func savePin(_ pin: String) -> Bool {
        let query = [kSecClass as String : kSecClassGenericPassword as String,
                     kSecAttrAccount as String : Defines.kPinKey,
                     kSecValueData as String : pin.data(using: .utf8)!] as [String : Any]
        let status = SecItemAdd(query as CFDictionary, nil)
        return status == noErr
    }
    
    class func fetchPin() -> String? {
        let query = [kSecClass as String : kSecClassGenericPassword as String,
                      kSecAttrAccount as String : Defines.kPinKey,
                      kSecReturnData as String  : kCFBooleanTrue!,
                      kSecMatchLimit as String  : kSecMatchLimitOne] as [String : Any]
        var dataRef: AnyObject? = nil
        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataRef)
        
        if (status == noErr) {
            let data = dataRef as! Data?
            return String(decoding: data!, as: UTF8.self)
        }
        return nil
    }
}
