//
//  TransactionCell.swift
//  Transactions
//
//  Created by Elvira Scablinska on 27/01/2022.
//

import UIKit

class TransactionCell: UITableViewCell {

    @IBOutlet weak var counterPartyInfoLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupData(_ transaction: Transaction) {
        counterPartyInfoLabel.text = String("\(transaction.counterPartyName ?? "") \(transaction.counterPartyAccount ?? "")")
        descriptionLabel.text = transaction.description_
        dateLabel.text = transaction.date
        amountLabel.text = transaction.amount
    }
}
