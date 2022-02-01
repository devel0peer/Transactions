//
//  ViewController.swift
//  Transactions
//
//  Created by Elvira Scablinska on 26/01/2022.
//

import UIKit

class PinViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var pinField: LimitedTextField!
    @IBOutlet weak var pinFieldLabel: UILabel!
    @IBOutlet weak var errorLabel: ErrorLabel!
    @IBOutlet weak var confirmationButton: UIButton!
    
    var hasPin: Bool!
    let kPinLength = 4
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pinField.delegate = self
        
        hasPin = pin() != nil
        pinFieldLabel.text = hasPin ? "Enter your PIN" : "Create PIN"
        confirmationButton.isHidden = hasPin
        confirmationButton.isEnabled = false
    }
    
    func openList() {
        performSegue(withIdentifier: "openListId", sender: nil)
    }
    
    @IBAction func confirmPressed(_ sender: Any) {
        let saved = Keychain.savePin(pinField.text)
        if(!saved) {
            errorLabel.text = "Fatal error! Unable to save PIN"
            errorLabel.isHidden = false
        }else {
            openList()
        }
    }
    
    @IBAction func textChanged(_ sender: LimitedTextField) {
        if (hasPin) {
            checkPinOk(sender.text)
        }else {
            allowCreatePin(sender.text)
        }
    }
    
    func checkPinOk(_ txt: String) {
        errorLabel.isHidden = true
        if (txt == pin()!) {
            openList()
        }else if (txt.count == kPinLength) {
            errorLabel.isHidden = false
        }
    }
    
    func allowCreatePin(_ pin: String) {
        confirmationButton.isEnabled = pin.count == kPinLength
    }
    
    func pin() -> String? {
        return Keychain.fetchPin()
    }

    //MARK: UITextFieldDelegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        errorLabel.isHidden = true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return (pinField.text as NSString).replacingCharacters(in: range, with: string).count <= kPinLength
    }
}
