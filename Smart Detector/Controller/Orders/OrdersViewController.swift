//
//  OrdersViewController.swift
//  Smart Detector
//
//  Created by Nnamdi Ugwuoke on 4/15/19.
//  Copyright © 2019 Manipal University Dubai. All rights reserved.
//

import UIKit
import Firebase

class OrdersViewController: UIViewController {
    var refDb: DatabaseReference!
    let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = UIImage(named: "220px-Manipal_University_logo.png")
        return iv
    }()
    
    lazy var phoneContainerView: UIView = {
        let view = UIView()
        return view.textContainerView(view: view, UIImage(named: "ic_person_outline_white_2x.png")!.withRenderingMode(.alwaysOriginal), phoneTextField)
    }()
    
    lazy var addressContainerView: UIView = {
        let view = UIView()
        return view.textContainerView(view: view, #imageLiteral(resourceName: "ic_lock_outline_white_2x"), addressTextField)
    }()
    
    lazy var phoneTextField: UITextField = {
        let tf = UITextField()
        return tf.textField(withPlaceolder: "Phone", isSecureTextEntry: false)
    }()
    
    lazy var addressTextField: UITextField = {
        let tf = UITextField()
        return tf.textField(withPlaceolder: "Address", isSecureTextEntry: false)
    }()
    
    let submitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Submit Order", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.setTitleColor(UIColor.mainBlue(), for: .normal)
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(handleSubmit), for: .touchUpInside)
        button.layer.cornerRadius = 5
        return button
    }()
    @objc func handleSubmit() {
        guard let name = phoneTextField.text else { return }
        guard let phone = phoneTextField.text else { return }
        guard let address = addressTextField.text else { return }
        
        createOrders(withName: name, withPhone: phone, address: address, medList: [])
    }
    
    func createOrders(withName name: String, withPhone phone: String, address: String, medList: [String]) {
        
 
            
      
            
           guard let uid = Auth.auth().currentUser?.uid else { return }
         refDb = Database.database().reference().child("users").child(uid)
             let key = refDb.childByAutoId().key
        var values = ["txnId": key,"name": name, "phone": phone, "address": address, "progress": "newly created", "medList" : medList] as [String : Any]
            refDb.child(key).updateChildValues(values, withCompletionBlock: { (error, ref) in
                if let error = error {
                    print("Failed to update database values with error: ", error.localizedDescription)
                    return
                }
            })

        values = ["userId": uid, "txnId": key, "name": name, "phone": phone, "address": address,"progress": "newly created", "medList" : medList] as [String : Any]
        refDb = Database.database().reference().child("orders")
        refDb.child(key).updateChildValues(values, withCompletionBlock: { (error, ref) in
            if let error = error {
                print("Failed to update database values with error: ", error.localizedDescription)
                return
            }
        })
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
         configureViewComponents()

        // Do any additional setup after loading the view.
    }
    

    // MARK: - Helper Functions
    
    func configureViewComponents() {
        view.backgroundColor = UIColor.mainBlue()
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(logoImageView)
        logoImageView.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 60, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 150, height: 150)
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(phoneContainerView)
        phoneContainerView.anchor(top: logoImageView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 24, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: 50)
        
        view.addSubview(addressContainerView)
        addressContainerView.anchor(top: phoneContainerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 16, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: 50)
        
        view.addSubview(submitButton)
        submitButton.anchor(top: addressContainerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 24, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: 50)
        
    
    }
    
}
