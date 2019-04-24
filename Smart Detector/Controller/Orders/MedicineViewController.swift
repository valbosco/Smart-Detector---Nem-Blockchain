//
//  MedicineViewController.swift
//  Smart Detector
//
//  Created by Nnamdi Ugwuoke on 4/17/19.
//  Copyright © 2019 Manipal University Dubai. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "Cell2"
private let headerId = "headerId"
class MedicineViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var refDb: DatabaseReference!

    var searchBarHeight : Int = 40
    var delegate: HomeControllerDelegate?
    var array: [MedData] = []
    var filtered: [MedData] = []
    var isSearching:Bool = false
    var addToCart: Bool = false
    var indexNo: Int = 0
    
    lazy var searchBar = UISearchBar(frame:CGRect(x: 0, y: 0, width:
        Int(UIScreen.main.bounds.width), height: searchBarHeight))
    var modRecord : Int  = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        let firstRecord = MedData(name:"Panadol", price: 10, productId: "#7838939938", productImage: "panadol", category : "headache")
          let secondRecord = MedData(name:"Benylin", price: 25, productId: "#5437733903", productImage: "cough syrup", category : "cough")
        let thirdRecord = MedData(name:"injection", price: 15, productId: "#6594930393", productImage: "malaria injection", category : "injection")
        array.append( firstRecord)
        array.append(secondRecord)
        array.append(thirdRecord)
          self.collectionView?.backgroundColor = .white
        
        self.collectionView!.register(MedicineListCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView?.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

  
            view.addSubview(searchBar)
        
        searchBar.anchor(top: view.topAnchor, left: view.leftAnchor,right: view.rightAnchor, paddingTop: 70, paddingLeft: 10, paddingRight: 10)
         searchBar.delegate = self
        collectionView.dataSource = self
        // Do any additional setup after loading the view.
    }
    override func viewDidDisappear(_ animated: Bool) {
        searchBar.text = ""
        isSearching = false
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items  if isSearching{
          if isSearching{
            return filtered.count
        
                }else{
            return array.count
        }
    }
    func  collectionView(_ collectionView: UICollectionView, layout collectionViewLayout : UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize{
        // return (CGSize(width: view.bounds.width, height: CGFloat(60)))
        return (CGSize(width: view.bounds.width, height: 70))
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return(CGSize(width: 165, height: 100))
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MedicineListCell
        cell.contentView.layer.cornerRadius = 4.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        cell.layer.shadowRadius = 4.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        cell.backgroundColor = .white
        
        if isSearching {
            cell.iconImageView.image = UIImage(named: filtered[indexPath.row].productImage)
            cell.titleLabel.text = filtered[indexPath.row].name
            cell.subtitleLabel.text =  "AED " + (String)(filtered[indexPath.row].price)
            if addToCart && indexNo == indexPath.row {
                cell.addToCartButton.setTitle("added to Cart", for: .normal)
                cell.addToCartButton.titleLabel?.textColor = UIColor.black
                 cell.addToCartButton.tintColor = UIColor.black
                cell.addToCartButton.backgroundColor = .yellow
           
            }
            
        }else {
            cell.iconImageView.image = UIImage(named: array[indexPath.row].productImage)
            cell.titleLabel.text = array[indexPath.row].name
            cell.subtitleLabel.text = "AED " + (String)(array[indexPath.row].price)
            if addToCart && indexNo == indexPath.row  {
                cell.addToCartButton.setTitle("added to Cart", for: .normal)
                 cell.addToCartButton.titleLabel?.textColor = UIColor.black
                 cell.addToCartButton.tintColor = UIColor.black
                cell.addToCartButton.backgroundColor = .yellow
               
               
            }
            
        }
//
//        cell.contentView.layer.cornerRadius = 4.0
//        cell.contentView.layer.borderWidth = 1.0
//        cell.contentView.layer.borderColor = UIColor.clear.cgColor
//        cell.contentView.layer.masksToBounds = false
//        cell.layer.shadowColor = UIColor.gray.cgColor
//        cell.layer.shadowOffset = CGSize(width: 0, height: 1.0)
//        cell.layer.shadowRadius = 4.0
//        cell.layer.shadowOpacity = 1.0
//        cell.layer.masksToBounds = false
//        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
//        cell.backgroundColor = .white
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if addToCart {
            addToCart = false
            indexNo = 0
            collectionView.reloadData()
        }else{
           addToCart = true
            collectionView.reloadData()
            indexNo = indexPath.row
        }
        
    }
    @objc func addDetails() {
        
        let detailVC = MyViewController()
       // detailVC.delegate = self
        detailVC.mode = .add
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func add(record: MyData) {
        
      //  array.append(record)
        array.sort { $0.name < $1.name }
        collectionView?.reloadData()
    }
    
    func modify(record: MyData) {
        
        let indexPath = collectionView?.indexPathsForSelectedItems
        
        array.remove(at: indexPath![0].row)
      //  array.append(record)
        array.sort { $0.name < $1.name }
        collectionView?.reloadData()
    }
    func configureUI(){
        
        view.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = .black
       // navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Medicine Catalog"
        
        navigationController?.navigationBar.barStyle = .black
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "baseline_clear_white_36pt_3x.png")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleDismiss))
           navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "checkout.png")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleCheckout))
    }

    
    
    //Mark: -Selectors
    @objc func handleDismiss(){
        dismiss(animated: true, completion: nil)
    }
    @objc func handleCheckout(){
          createOrders(withName: "Nnamdi", withPhone: "0547328273", address: "France Cluste IC, Dubai", medList: ["Panadol", "Benylin"])
        alertTheUser(title: " Thank You", message: "Your order  was placed created Successfully")
    }
    

    
    private func alertTheUser(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(ok)
        self.present(alert, animated: false, completion: nil)
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
}
