//
//  CarrierVC.swift
//  Smart Detector
//
//  Created by Nnamdi Ugwuoke on 4/7/19.
//  Copyright © 2019 Manipal University Dubai. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"
private let headerId = "headerId"
class CarrierVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var  record = MyData()
    var  recordCarrier = CarrierData()
    var record3 = NewOrder()
    var arrayCarrier: [CarrierData] = []
    var  mode: Mode!
    var  delegate2: NewDeliveryCollectionVC?
    var scanMed: Bool = true
    var setDestination: Bool = false
    var setCarrier: Bool = false
    var modRecord: Int = -1
    var record2 = CarrierData()
    var searchBarHeight : Int = 40
    var delegate: HomeControllerDelegate?
    var array: [CarrierData] = []
    var filtered: [CarrierData] = []
    var isSearching:Bool = false
    lazy  var searchBar = UISearchBar(frame:CGRect(x: 0, y: 0, width:
        Int(UIScreen.main.bounds.width), height: searchBarHeight))
   
    override func viewDidLoad() {
        super.viewDidLoad()
        let firstRecord = CarrierData(name: "John", address: "post office international city", rating:"fivestar-rating", deliveryNo: "Deliveries: 0 ")
        let secondRecord = CarrierData(name: "George", address: "DSO sillcon oasis", rating:"3.5 rating", deliveryNo: "Deliveries: 2")
        let thirdRecord = CarrierData(name: "Kenedy", address: "SIT towers silicon oasis", rating:"fivestar-rating", deliveryNo: "Deliveries: 5 ")
        let fourthRecord = CarrierData(name: "Bello", address: "Al baraha supermarket deira", rating:"3.5 rating", deliveryNo: "Deliveries: 0 ")
        array.append( firstRecord)
        array.append( secondRecord)
        
        array.append( thirdRecord)
        array.append( fourthRecord)
        
        self.collectionView?.backgroundColor = .gray
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(CarrierVCcell.self, forCellWithReuseIdentifier: reuseIdentifier)

        self.collectionView?.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
         view.addSubview(searchBar)
              searchBar.delegate = self
        // Do any additional setup after loading the view.
        searchBar.anchor(top: view.topAnchor, left: view.leftAnchor,right: view.rightAnchor, paddingTop: 60, paddingLeft: 10, paddingRight: 10)
    }
    override func viewDidDisappear(_ animated: Bool) {
        searchBar.text = ""
        isSearching = false
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
        if isSearching{
            
            return filtered.count
            
        }else{
            return array.count
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CarrierVCcell
          cell.backgroundColor = .white
        if isSearching {
            cell.deliveriesNoLabel.text = filtered[indexPath.row].deliveryNo
            cell.rating.image = UIImage(named: filtered[indexPath.row].rating)
            cell.titleLabel.text = filtered[indexPath.row].name
            cell.subtitleLabel.text = filtered[indexPath.row].address
            
        }else {
            cell.deliveriesNoLabel.text = array[indexPath.row].deliveryNo
            cell.rating.image = UIImage(named: array[indexPath.row].rating)
            cell.titleLabel.text = array[indexPath.row].name
            cell.subtitleLabel.text = array[indexPath.row].address
        }
        
    
        return cell
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
       // header.addSubview(searchBar)
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
    func  collectionView(_ collectionView: UICollectionView, layout collectionViewLayout : UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize{
        // return (CGSize(width: view.bounds.width, height: CGFloat(60)))
        return (CGSize(width: view.bounds.width, height: 60))
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return(CGSize(width: view.bounds.width, height: 80))
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
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        record3.stepCompleted = true
        record3.subTitle = array[indexPath.row].name
        
        
       // record2.street = array[indexPath.row].city
        // record2.subTitle = " \(qrSeen.count) Medicine scanned"
        // record2.stepCompleted = true
        if mode == .add {
            delegate2?.add(record: record3)
        } else if mode == .edit {
            delegate2?.modify(record: record3)
            delegate2?.modify(record: record2)
            delegate2?.setCreateBtn()
        }
        else {
            print ("This Shouldn't Happen")
        }
        navigationController?.popViewController(animated: true)
        
    }

}
