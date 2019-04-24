//
//  NewDeliveryCollectionVC.swift
//  Smart Detector
//
//  Created by Nnamdi Ugwuoke on 4/5/19.
//  Copyright © 2019 Manipal University Dubai. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"
private let headerId = "headerId"
private let footerId = "footerId"

class NewDeliveryCollectionVC: UICollectionViewController, UICollectionViewDelegateFlowLayout        {
    var  record = MyData()
    var  recordLocation = locationData()
     var  recordCarrier = CarrierData()
    var array: [NewOrder] = []
    var arrayLocation: [locationData] = []
    var arrayCarrier: [CarrierData] = []
    var  mode: Mode!
    var  delegate: MyCollectionViewController!
    var scanMed: Bool = true
    var setDestination: Bool = false
    var setCarrier: Bool = false
    var modRecord: Int = -1
    let createBtn: UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 0, y: 0, width: 300, height: 42)
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.white.cgColor
        button.titleLabel?.textColor = UIColor.blue
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.tintColor = UIColor.white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Create Delivery", for: .normal)
        button.isEnabled = false
        button.addTarget(self, action: #selector(handleCreate), for: .touchUpInside)
        button.backgroundColor = UIColor.gray
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        let firstRecord = NewOrder(number: "1", iconImage: "qrcodeIcon.png", title:"Medicines", subTitle: "0 Medicines", stepCompleted: false)
        let secondRecord = NewOrder(number: "2", iconImage: "ic_location.png", title:"Destination", subTitle: "Please Select Destination",stepCompleted: false)
        let thirdRecord = NewOrder(number: "3", iconImage: "ic_carrier.png", title:"Carrier", subTitle: "Please Select Carrier", stepCompleted: false)
        array.append(firstRecord)
         array.append(secondRecord)
         array.append(thirdRecord)
        // set up location data
        let firstRecord2 = locationData(street: "France cluster", city: "international city", state:"Dubai", country: "united Arab Emirates")
        let secondRecord2 = locationData(street: "China cluster", city: "international city", state:"Dubai", country: "united Arab Emirates")
        let thirdRecord2 = locationData(street: "Silicon gate 1", city: "Silicon Oasis", state: "Dubai", country: "United Arab Emirates")
        let fourthRecord2 = locationData(street: "Hor Ans 5", city: "Abu Hail", state:"Dubai", country: "united Arab Emirates")
        arrayLocation.append(firstRecord2)
         arrayLocation.append(secondRecord2)
         arrayLocation.append(thirdRecord2)
         arrayLocation.append(fourthRecord2 )
        
        //load third data
        let firstRecord3 = CarrierData(name: "John", address: "post office international city", rating:"fivestar-rating", deliveryNo: "Deliveries: 0 ")
        let secondRecord3 = CarrierData(name: "George", address: "DSO sillcon oasis", rating:"3.5 rating", deliveryNo: "Deliveries: 2")
        let thirdRecord3 = CarrierData(name: "Kenedy", address: "SIT towers silicon oasis", rating:"fivestar-rating", deliveryNo: "Deliveries: 5 ")
        let fourthRecord3 = CarrierData(name: "Bello", address: "Al baraha supermarket deira", rating:"3.5 rating", deliveryNo: "Deliveries: 0 ")
        arrayCarrier.append( firstRecord3)
        arrayCarrier.append( secondRecord3)
        
        arrayCarrier.append( thirdRecord3)
        arrayCarrier.append( fourthRecord3)
        
        self.collectionView?.backgroundColor = .white
       // setUpNavigation()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(NewDeliveryCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView?.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        self.collectionView?.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerId)

        // Do any additional setup after loading the view.
    }
 

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 3
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! NewDeliveryCell
        
       
        (cell.numberContainerView.subviews.first as! UILabel).text = array[indexPath.row].number
           cell.iconImageView.image = UIImage(named: array[indexPath.row].iconImage)
        if array[indexPath.row].stepCompleted{
      cell.arrorIconImageView.image = UIImage(named: "green-check-mark")
            
        }
        
        cell.titleLabel.text = array[indexPath.row].title
       
        cell.subtitleLabel.text = array[indexPath.row].subTitle
        if indexPath.row == 1 {
            if recordLocation.city != "" {
               cell.subtitleLabel.text = recordLocation.city
            }
        }

        
        
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
        // Configure the cell
     cell.backgroundColor = .white
        if scanMed == false && indexPath.row == 0 {
         let overlayView = UIView()
        overlayView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.03)
        overlayView.frame = cell.bounds
        cell.addSubview(overlayView)
        }
        if (setDestination == false && indexPath.row == 1 ){
            let overlayView = UIView()
            overlayView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.02)
            overlayView.frame = cell.bounds
            cell.addSubview(overlayView)
        }
        if (setCarrier == false && indexPath.row == 2 ){
            let overlayView = UIView()
            overlayView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.02)
            overlayView.frame = cell.bounds
            cell.addSubview(overlayView)
        }
        return cell
    }
  
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return(CGSize(width: view.bounds.width, height: 100))
    }
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath)
            header.backgroundColor = .white
            let cvTitleLabel: UILabel = {
                let label = UILabel()
                label.textColor = .blue
                label.font = UIFont.boldSystemFont(ofSize: 24)
                label.translatesAutoresizingMaskIntoConstraints = false
                label.text = "Prepare New Delivery"
                //label.alpha = 0
                return label
            }()
            let cancelBtn: UIButton = {
                let button = UIButton(type: .system)
                button.frame = CGRect(x: 0, y: 0, width: 300, height: 42)
               // button.layer.borderWidth = 1.0
               // button.layer.borderColor = UIColor.white.cgColor
                button.titleLabel?.textColor = UIColor.blue
                button.tintColor = UIColor.blue
                button.translatesAutoresizingMaskIntoConstraints = false
                button.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
                button.setTitle("cancel", for: .normal)
                
                return button
            }()
            header.addSubview(cvTitleLabel)
            header.addSubview(cancelBtn)
           
            cvTitleLabel.topAnchor.constraint(equalTo: header.topAnchor, constant: 20).isActive = true
            cvTitleLabel.leftAnchor.constraint(equalTo: header.leftAnchor, constant: 20).isActive = true
            cvTitleLabel.topAnchor.constraint(equalTo: header.topAnchor, constant: 20).isActive = true
            cvTitleLabel.bottomAnchor.constraint(equalTo: header.bottomAnchor, constant: -20).isActive = true
            
            
            cancelBtn.topAnchor.constraint(equalTo: header.topAnchor, constant: 20).isActive = true
            cancelBtn.rightAnchor.constraint(equalTo: header.rightAnchor, constant: -20).isActive = true
            cancelBtn.topAnchor.constraint(equalTo: header.topAnchor, constant: 20).isActive = true
           cancelBtn.bottomAnchor.constraint(equalTo: header.bottomAnchor, constant: -20).isActive = true
            
            return header
        } else {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerId, for: indexPath)
           // footer.backgroundColor = .green

            footer.addSubview(createBtn)
                     //  createBtn.bottomAnchor.constraint(equalTo: footer.bottomAnchor, constant: -20).isActive = true
           // createBtn.centerYAnchor.constraint(equalTo: footer.centerYAnchor).isActive = true
           // createBtn.centerXAnchor.constraint(equalTo: footer.centerXAnchor).isActive = true
            createBtn.anchor(top: footer.topAnchor, left: footer.leftAnchor, bottom: footer.bottomAnchor, right: footer.rightAnchor, paddingTop: 70, paddingLeft: 30, paddingBottom: 30, paddingRight: 30, width: 450, height: 50)
            return footer
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 150)
    }
    func setUpNavigation() {
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
        navigationItem.titleView = titleLabel
        if record.name.isEmpty {
            titleLabel.text = "Pharmaist"
        } else {
            titleLabel.text = "Edit Record"
        }
        titleLabel.textAlignment = .center
        titleLabel.textColor = .black
        
        //navigationItem.rightBarButtonItem = saveButton
       // navigationItem.leftBarButtonItem = cancelButton
        
    }

    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let view = UIView()
//        view.backgroundColor = .blue
//        let title = UILabel()
//        title.font = UIFont.boldSystemFont(ofSize: 20)
//        title.textColor = .blue
//        title.text =  "Prepare New Delivery"
//        view.addSubview(title)
//        title.translatesAutoresizingMaskIntoConstraints = false
//        title.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//        title.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
//        title.translatesAutoresizingMaskIntoConstraints = false
//
//
//
//        return view
//    }
    func  collectionView(_ collectionView: UICollectionView, layout collectionViewLayout : UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize{
        return (CGSize(width: view.bounds.width, height: 100))
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            if scanMed {
            let controller = HomeController()
            controller.delegate2 = self
            
           controller.mode = .edit
          controller.record2 = array[indexPath.row]
                setCellOne()
         navigationController?.pushViewController(controller, animated: true)
       
                
            }
               //present(UINavigationController(rootViewController: controller), animated: true, completion: nil)
        case 1:
            if setDestination {
            let flowLayout = UICollectionViewFlowLayout()
            let controller = DestinationVC(collectionViewLayout: flowLayout)
                controller.delegate2 = self
                   controller.mode = .edit
                for record in arrayLocation {
                    modRecord += 1
                    if record.city == arrayLocation[indexPath.row].city{
                        break
                    }
                }
                controller.record3 = array[indexPath.row]
                controller.record2 = arrayLocation[indexPath.row]
            navigationController?.pushViewController(controller, animated: true)
               
                setDestination = false
                setCarrier = true
            //present(UINavigationController(rootViewController: controller), animated: true, completion: nil)
            }
  
        case 2:
            if setCarrier {
                let flowLayout = UICollectionViewFlowLayout()
                let controller = CarrierVC(collectionViewLayout: flowLayout)
                controller.delegate2 = self
                controller.mode = .edit
                for record in arrayCarrier {
                    modRecord += 1
                    if record.name == arrayCarrier[indexPath.row].name{
                        break
                    }
                }
                controller.record3 = array[indexPath.row]
                controller.record2 = arrayCarrier[indexPath.row]
                
              
                navigationController?.pushViewController(controller, animated: true)
            //print(3)
            }
        default:
              print("not in the menu")
        }
        //let detailVC = MyViewController()
     //   let flowLayout = UICollectionViewFlowLayout()
       // let detailVC = NewDeliveryCollectionVC(collectionViewLayout: flowLayout)
       // detailVC.delegate = self
//        detailVC.mode = .edit
//        if isSearching{
//            detailVC.record = filtered[indexPath.row]
//        }else {
//            detailVC.record = array[indexPath.row]
//        }
 //       navigationController?.pushViewController(detailVC, animated: true)
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
    
    func add(record: NewOrder) {
        
        array.append(record)
        array.sort { $0.number < $1.number }
        collectionView?.reloadData()
    }
    
    func modify(record: NewOrder) {
        
        let indexPath = collectionView?.indexPathsForSelectedItems
        
        array.remove(at: indexPath![0].row)
        array.append(record)
        array.sort { $0.number < $1.number }
        collectionView?.reloadData()
    }
    func modify(record: locationData ) {
        
        let indexPath = collectionView?.indexPathsForSelectedItems
        if modRecord != -1 {
          arrayLocation.remove(at: modRecord)
            modRecord = -1
        }else{
            arrayLocation.remove(at: indexPath![0].row)
        }
        
        arrayLocation.append(recordLocation)
        //array.sort { $0.city < $1.city }
        collectionView?.reloadData()
    }
    
    func modify(record: CarrierData ) {
        
        let indexPath = collectionView?.indexPathsForSelectedItems
      
        if modRecord != -1 {
            arrayCarrier.remove(at: modRecord)
            modRecord = -1
        }else{
            arrayCarrier.remove(at: indexPath![0].row)
        }
        
        arrayCarrier.append(recordCarrier)
        //array.sort { $0.city < $1.city }
        collectionView?.reloadData()
    }
    @objc func handleCancel(){
           navigationController?.popViewController(animated: true)
    }

    @objc func handleCreate(){
        alertTheUser(title: "SUCCESS MESSAGE", message: "Transaction created Successfully")
    }
    
    private func alertTheUser(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(ok)
        self.present(alert, animated: false, completion: nil)
    }
    func setCreateBtn(){
        
        setCarrier = false
        createBtn.isEnabled = true
        createBtn.backgroundColor = UIColor.green
    }
    func setCellOne(){
        scanMed = false
        setDestination = true
        setCarrier = false
    }
}
