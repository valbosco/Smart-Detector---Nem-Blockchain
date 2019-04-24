//
//  SendXemViewController.swift
//  Smart Detector
//
//  Created by Nnamdi Ugwuoke on 4/24/19.
//  Copyright © 2019 Manipal University Dubai. All rights reserved.
//

import UIKit
import Nem2SdkSwift
import RxSwift


class SendXemViewController: UIViewController {
    let address: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = "Address "
        return label
    }()
    let textAddress: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = "Loading..."
        return label
    }()
     let textMessage: UITextView = {
    let textMsg = UITextView(frame: CGRect(x: 20.0, y: 90.0, width: 250.0, height: 100.0))
    textMsg.textAlignment = NSTextAlignment.justified
   textMsg.backgroundColor = UIColor.lightGray
    // Use RGB colour
    textMsg.backgroundColor = UIColor(red: 39/255, green: 53/255, blue: 182/255, alpha: 1)
    // Update UITextView font size and colour
    textMsg.font = UIFont.systemFont(ofSize: 20)
    textMsg.textColor = UIColor.white
    textMsg.font = UIFont.boldSystemFont(ofSize: 20)
    textMsg.font = UIFont(name: "Verdana", size: 17)
    // Capitalize all characters user types
   textMsg.autocapitalizationType = UITextAutocapitalizationType.allCharacters
   
    // Make UITextView corners rounded
    textMsg.layer.cornerRadius = 10
    // Enable auto-correction and Spellcheck
    textMsg.autocorrectionType = UITextAutocorrectionType.yes
    textMsg.spellCheckingType = UITextSpellCheckingType.yes
    // myTextView.autocapitalizationType = UITextAutocapitalizationType.None
    // Make UITextView Editable
   textMsg.isEditable = true
        return textMsg
    }()
    let AccountInfoBtn: UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 0, y: 0, width: 300, height: 42)
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.white.cgColor
        button.titleLabel?.textColor = UIColor.blue
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.tintColor = UIColor.blue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Account Info", for: .normal)
       
        button.addTarget(self, action: #selector(onTouchedAccountInfo), for: .touchUpInside)
       // button.backgroundColor = UIColor.gray
        return button
    }()
    
    let SendXemBtn: UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 0, y: 0, width: 300, height: 42)
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.white.cgColor
        button.titleLabel?.textColor = UIColor.blue
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.tintColor = UIColor.blue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Send Xem", for: .normal)
     
        button.addTarget(self, action: #selector(onTouchedSendXem), for: .touchUpInside)
       // button.backgroundColor = UIColor.gray
        return button
    }()
    
    
   // self.view.addSubview(textMessage)
    
    //@IBOutlet weak var textAddress: UILabel!
   // @IBOutlet weak var textMessage: UITextView!
    var account: Account!
    
    static let url = URL(string: "http://192.168.10.9:3000")!
    
    let accountHttp = AccountHttp(url: SendXemViewController.url)
    let transactionHttp = TransactionHttp(url: SendXemViewController.url)
    let listener = Listener(url: SendXemViewController.url)
    let disposeBag = DisposeBag()
    
    //let privateKey: String? = nil
    let privateKey: String? = "7DC9CB2015E7E180E86F6037E79EEF98F347056ADF89324A97858D7628433652"
    override func viewDidLoad() {
        super.viewDidLoad()
    setUpView()
    setUpConstraint()
  
        
     
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func onTouchedAccountInfo() {
        fetchAccountInfo()
    }
    
    @objc func onTouchedSendXem() {
        let alert = UIAlertController(title: "Send XEM", message: "Input Address and Micro NEM", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.keyboardType = .asciiCapable
            textField.placeholder = "Receiver Address"
        }
        alert.addTextField { (textField) in
            textField.keyboardType = .numberPad
            textField.placeholder = "Micro NEM"
        }
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self](action:UIAlertAction!) -> Void in
            guard let weakSelf = self else {
                return
            }
            let addressField = alert.textFields![0] as UITextField
            let microXemField = alert.textFields![1] as UITextField
            guard let address = addressField.text,
                let microXemText = microXemField.text,
                let microXem = Int(microXemText) else {
                    print("Failed to analyze input")
                    return
            }
            weakSelf.textMessage.text = ""
            do {
                try weakSelf.sendXem(address, UInt64(microXem))
            }
            catch let error {
                print(error.localizedDescription)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (action:UIAlertAction!) -> Void in }
        
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    private func setupAccount() -> Account? {
        if let privateKey = self.privateKey {
            return try? Account(privateKeyHexString: privateKey, networkType: .mijinTest)
        } else {
            return Account(networkType: .mijinTest)
        }
    }
    
    private func clearMessage() {
        textMessage.text = ""
    }
    
    private func showMessage(_ message: String) {
        textMessage.text.append(message + "\n")
    }
    
    private func fetchAccountInfo() {
        clearMessage()
        
        accountHttp.getAccountInfo(address: account.address)
            .subscribeOn(ConcurrentMainScheduler.instance)
            .observeOn(MainScheduler.instance)
            .subscribe(
                onSuccess: { (result: AccountInfo) in
                    if let xem = result.mosaics.first(where: { mosaic in mosaic.id == XEM.mosaicId }) {
                        self.showMessage("balance: \(xem.amount) micro xem")
                    }
            },
                onError: { error in
                    self.showMessage(error.localizedDescription)
            }
            ).disposed(by: disposeBag)
    }
    
    
    private func sendXem(_ recipientAddress: String, _ microXem: UInt64) throws {
        clearMessage()
        // Create transfer transaction
        let transaction = TransferTransaction.create(
            recipient: try Address(address: recipientAddress, networkType: .mijinTest),
            mosaics: [XEM.of(microXemAmount: microXem)],
            message: PlainMessage.empty,
            networkType: .mijinTest)
        
        // Sign the transaction
        let signedTransaction = account.sign(transaction: transaction)
        
        // Send
        transactionHttp.announce(signedTransaction: signedTransaction)
            .subscribeOn(ConcurrentMainScheduler.instance)
            .observeOn(MainScheduler.instance)
            .subscribe(
                onSuccess: { (result: TransactionAnnounceResponse) in
                    self.showMessage(result.message)
                    self.showTransactionStatus(signedTransaction.hash)
            },
                onError: { error in
                    self.showMessage(error.localizedDescription)
            }
            ).disposed(by: disposeBag)
    }
    
    private func showTransactionStatus(_ hash: [UInt8]) {
        // get transaction status and print
        transactionHttp.getTransactionStatus(hash: hash)
            .subscribeOn(ConcurrentMainScheduler.instance)
            .observeOn(MainScheduler.instance)
            .subscribe(
                onSuccess: { (status: TransactionStatus) in
                    self.showMessage(status.status)
            },
                onError: { error in
                    // retry
                    self.showTransactionStatus(hash)
            }
            ).disposed(by: disposeBag)
        
    }

    public func setUpView(){
        view.backgroundColor = .white
        view.addSubview(address)
        view.addSubview(textAddress)
        view.addSubview(textMessage)
        view.addSubview(AccountInfoBtn)
        view.addSubview(SendXemBtn)
        navigationController?.navigationBar.barStyle = .black
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "baseline_clear_white_36pt_3x.png")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleDismiss))
        
    }
    public func setUpConstraint(){
        
        address.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 70, paddingLeft: 20,paddingRight: 20)
        textAddress.anchor(top: address.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 10, paddingLeft: 20,paddingRight: 20)
        textMessage.anchor(top: textAddress.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 10, paddingLeft: 30,paddingRight: 30, width: view.bounds.width, height: 350 )
      AccountInfoBtn.anchor(top: textMessage.bottomAnchor, left: view.leftAnchor, paddingTop: 10, paddingLeft: 20)
     SendXemBtn.anchor(top: textMessage.bottomAnchor, right: view.rightAnchor, paddingTop: 10, paddingRight: 20)
        
        
    }
    //Mark: -Selectors
    @objc func handleDismiss(){
        dismiss(animated: true, completion: nil)
    }
}
