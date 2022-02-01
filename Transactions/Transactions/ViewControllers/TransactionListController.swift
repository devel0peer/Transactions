//
//  TransactionListController.swift
//  Transactions
//
//  Created by Elvira Scablinska on 26/01/2022.
//

import UIKit

class TransactionListController: UIViewController, UITableViewDelegate, UITableViewDataSource, DataLoadingDelegate {

    let kCellIdentifier = "kTransactionCellIdentifier"
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var errorLabel: ErrorLabel!
    
    var transactions: [Transaction] = [Transaction]()
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "TransactionCell", bundle: nil), forCellReuseIdentifier: kCellIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        
        requestData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        runUpdate()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        abortUpdate()
    }
    
    @objc func requestData() {
        let transactionManager = TransactionManager.shared
        transactionManager.delegate = self
        transactionManager.fetchData()
    }
    
    func runUpdate() {
        timer = Timer.scheduledTimer(timeInterval: 60, target: self,
                                     selector: #selector(TransactionListController.requestData),
                                     userInfo: nil, repeats: true)
    }
    
    func abortUpdate() {
        timer?.invalidate()
    }
    
    func showError(show: Bool, hasData: Bool) {
        if (show) {
            errorLabel.text = hasData ? "Unable update data" : "No transactions"
        }
        errorLabel.isHidden = !show
    }
    
    func showTable(hasData: Bool){
        tableView.isHidden = !hasData
        amountLabel.isHidden = !hasData
        
        if (hasData) {
            amountLabel.text = "\(Database.shared.sumTotal())"
            tableView.reloadData()
        }
    }
    
    func updateViewFor(failure: Bool) {
        let hasData = hasTransactions()
        showError(show: failure, hasData: hasData)
        showTable(hasData: hasData)
    }
    
    func hasTransactions() -> Bool {
        transactions = Database.shared.findAllTransactions()
        return transactions.count != 0
    }
    
    //MARK: DataLoadingDelegate
    
    func fetchFailed() {
        DispatchQueue.main.async {
            self.updateViewFor(failure: true)
        }
    }
    
    func updateSucceeded() {
        DispatchQueue.main.async {
            self.updateViewFor(failure: false)
        }
    }
    
    //MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdentifier, for: indexPath) as! TransactionCell
        cell.setupData(transactions[indexPath.row])
        return cell
    }
    
    //MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.estimatedRowHeight
    }
}
