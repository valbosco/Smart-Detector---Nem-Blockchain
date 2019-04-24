//
//  MyCollectionViewController.swift
//  final
//

import UIKit
import Firebase

private let reuseIdentifier = "MyCell"
private let headerId = "headerId"

class MyCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
     var refDb: DatabaseReference!
    var searchBarHeight : Int = 40
    var delegate: HomeControllerDelegate?
    var array: [MyData] = []
    var filtered: [MyData] = []
    var isSearching:Bool = false
  
   lazy var searchBar = UISearchBar(frame:CGRect(x: 0, y: 0, width:
        Int(UIScreen.main.bounds.width), height: searchBarHeight))
    var modRecord : Int  = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
       // self.clearsSelectionOnViewWillAppear = false
        
       // let firstRecord = MyData(orderNumber: "No order Yet", address: "", name:"", status: true)
        
       // let secondRecord = MyData(orderNumber: "#599850303993", address: "Ajman, UAE", name:" Brian", status: true)
        //let secondRecord = MyData(name: "Brian", age: 27, gender: false)
        
      //  array.append( firstRecord)
        refDb = Database.database().reference().child("orders")
        refDb.observe(DataEventType.value) { (snapshot) in
            if snapshot.childrenCount > 0{
                self.array.removeAll()
                for transactions in (snapshot.children.allObjects as? [DataSnapshot])!{
                    let txnObject = transactions.value as? [String: AnyObject]
                    let userId = txnObject?["userId"]
                    let txnId = txnObject?["txnId"]
                    let name = txnObject?["name"]
                    let address = txnObject?["address"]
                    let progress = txnObject?["progress"]
                    
                    let txn = MyData(userId: userId  as! String , orderNumber: txnId as! String , address: address as! String, name: name as! String, progress: progress as! String)
                    self.array.append(txn)
                }
                self.collectionView.reloadData()
            }
        }
        
        
       // array.append( secondRecord)
        
      //  array.sort { $0.name < $1.name }
        
         //to be
       // navigationItem.title = "Today's Deliveries"
       // navigationController?.navigationBar.isTranslucent = false

        self.collectionView?.backgroundColor = .white
        
        // Register cell classes
        self.collectionView!.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
           self.collectionView?.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        
         //to be
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addDetails))

            //     let backbutton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(backAction))
        
//        let backbutton = UIButton(type: .custom)
//        backbutton.setImage(UIImage(named: "BackButton.png"), for: .normal)
//        // Image can be downloaded from here below link
//        //backbutton.setTitle("Back", for: .normal)
//        backbutton.setTitleColor(backbutton.tintColor, for: .normal)
//        // You can change the TitleColor
//        backbutton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
//
//
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backbutton)
        //to be
        navigationItem.rightBarButtonItem = addButton
        
        //navigationItem.leftBarButtonItem = backbutton
        // Do any additional setup after loading the view.
        configureNavigationBar()
 
        //view.addSubview(searchBar)
       view.addSubview(searchBar)
        searchBar.anchor(top: view.topAnchor, left: view.leftAnchor,right: view.rightAnchor, paddingTop: 70, paddingLeft: 10, paddingRight: 10)
        searchBar.delegate = self
     collectionView.dataSource = self
        
    }
    
    @objc func backAction(){
         dismiss(animated: true, completion: nil)
        //navigationController?.popViewController(animated: true)
    }
    override func viewDidDisappear(_ animated: Bool) {
        searchBar.text = ""
        isSearching = false
    }
    func  collectionView(_ collectionView: UICollectionView, layout collectionViewLayout : UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize{
       // return (CGSize(width: view.bounds.width, height: CGFloat(60)))
       return (CGSize(width: view.bounds.width, height: 70))
    }
    @objc func addDetails() {
        
        let detailVC = MyViewController()
       detailVC.delegate = self
        detailVC.mode = .add
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func add(record: MyData) {
        
        array.append(record)
        array.sort { $0.name < $1.name }
        collectionView?.reloadData()
    }
    
    func modify(record: MyData) {
        
        let indexPath = collectionView?.indexPathsForSelectedItems
        
        array.remove(at: indexPath![0].row)
        array.append(record)
        array.sort { $0.name < $1.name }
        collectionView?.reloadData()
    }
    

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //
        
        let detailVC = HomeController()
      //   let flowLayout = UICollectionViewFlowLayout()
      // let detailVC = NewDeliveryCollectionVC(collectionViewLayout: flowLayout)
       // detailVC.delegate = self
        detailVC.mode = .edit
        if isSearching{
            if filtered.count != 0{
         detailVC.record = filtered[indexPath.row]
            }
        }else {
        detailVC.record = array[indexPath.row]
        }
        navigationController?.pushViewController(detailVC, animated: true)
    }
    

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        if isSearching{
            
            return filtered.count
            
        }else{
            return array.count
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MyCollectionViewCell
        
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
            cell.orderNumberLabel.text = filtered[indexPath.row].orderNumber
            cell.nameLabel.text = filtered[indexPath.row].name
            cell.addressLabel.text = filtered[indexPath.row].address
            
            if array[indexPath.row].progress == "completed" {
                
                cell.statusBtn.backgroundColor = UIColor.yellow
                cell.statusBtn.setTitle(array[indexPath.row].progress, for: .normal)
            }else {
                cell.statusBtn.setTitle(array[indexPath.row].progress, for: .normal)
            }
            
            
        }else {
            cell.orderNumberLabel.text = array[indexPath.row].orderNumber
            cell.nameLabel.text = array[indexPath.row].name
            cell.addressLabel.text = array[indexPath.row].address
            if array[indexPath.row].progress == "completed" {
                
                cell.statusBtn.backgroundColor = UIColor.purple
                cell.statusBtn.setTitle(array[indexPath.row].progress, for: .normal)
            }else {
                cell.statusBtn.setTitle(array[indexPath.row].progress, for: .normal)
            }
            
        }
        
//        if isSearching {
//            cell.orderNumberLabel.text = filtered[indexPath.row].orderNumber
//            cell.nameLabel.text = filtered[indexPath.row].name
//            cell.addressLabel.text = filtered[indexPath.row].address
//
//
//        }else {
//            cell.orderNumberLabel.text = array[indexPath.row].orderNumber
//            cell.nameLabel.text = array[indexPath.row].name
//            cell.addressLabel.text = array[indexPath.row].address
//
//        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return(CGSize(width: view.bounds.width, height: 100))
    }
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
     //   if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath)
   //         header.backgroundColor = .white
//            let cvTitleLabel: UILabel = {
//                let label = UILabel()
//                label.textColor = .blue
//                label.font = UIFont.boldSystemFont(ofSize: 24)
//                label.translatesAutoresizingMaskIntoConstraints = false
//                label.text = "Delivery"
//                //label.alpha = 0
//                return label
//            }()
//            let cancelBtn: UIButton = {
//                let button = UIButton(type: .system)
//                button.frame = CGRect(x: 0, y: 0, width: 300, height: 42)
//                // button.layer.borderWidth = 1.0
//                // button.layer.borderColor = UIColor.white.cgColor
//                button.titleLabel?.textColor = UIColor.blue
//                button.tintColor = UIColor.blue
//                button.translatesAutoresizingMaskIntoConstraints = false
//                button.setTitle("cancel", for: .normal)
//
//                return button
//            }()
            //header.addSubview(cvTitleLabel)
          // header.addSubview(cancelBtn)
        
 //       header.addSubview(searchBar)
        
      //searchBar.delegate = self
//            cvTitleLabel.topAnchor.constraint(equalTo: header.topAnchor, constant: 20).isActive = true
//            cvTitleLabel.leftAnchor.constraint(equalTo: header.leftAnchor, constant: 20).isActive = true
//            cvTitleLabel.topAnchor.constraint(equalTo: header.topAnchor, constant: 20).isActive = true
//            cvTitleLabel.bottomAnchor.constraint(equalTo: header.bottomAnchor, constant: -20).isActive = true
//
//
//            cancelBtn.topAnchor.constraint(equalTo: header.topAnchor, constant: 20).isActive = true
//            cancelBtn.rightAnchor.constraint(equalTo: header.rightAnchor, constant: -20).isActive = true
//            cancelBtn.topAnchor.constraint(equalTo: header.topAnchor, constant: 20).isActive = true
//            cancelBtn.bottomAnchor.constraint(equalTo: header.bottomAnchor, constant: -20).isActive = true
        
            return header
       // }
    
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    @objc func handleMenuToggle(){
        delegate?.handleMenuToggle(forMenuOption: nil)
    }
    func signOut() {
        do {
            try Auth.auth().signOut()
            let navController = UINavigationController(rootViewController: LoginController())
            navController.navigationBar.barStyle = .black
            self.present(navController, animated: true, completion: nil)
        } catch let error {
            print("Failed to sign out with error..", error)
        }
    }
    //Mark: - selector
    @objc func handleSignOut() {
        let alertController = UIAlertController(title: nil, message: "Are you sure you want to sign out?", preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Sign Out", style: .destructive, handler: { (_) in
            self.signOut()
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func configureNavigationBar(){
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.barStyle = .black
        navigationItem.title = "Doctor"
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_person_outline_white_2x.png")!.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleSignOut))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_menu_white_3x").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMenuToggle))
        
    }
}
