//
//  DesinationVC.swift
//  Smart Detector
//
//  Created by Nnamdi Ugwuoke on 4/7/19.
//  Copyright © 2019 Manipal University Dubai. All rights reserved.
//

import UIKit


private let reuseIdentifier = "Cell"
private let headerId = "headerId"
var modRecord = -1
class DestinationVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
var searchBarHeight : Int = 40
var  mode: Mode!
var array: [locationData] = []
var filtered: [locationData] = []
var record2 = locationData()
var record3 = NewOrder()
var isSearching:Bool = false
var delegate: HomeControllerDelegate?
var  delegate2: NewDeliveryCollectionVC?
lazy  var searchBar = UISearchBar(frame:CGRect(x: 0, y: 0, width:
        Int(UIScreen.main.bounds.width), height: searchBarHeight))
    override func viewDidLoad() {
        super.viewDidLoad()
        let firstRecord = locationData(street: "France cluster", city: "international city", state:"Dubai", country: "united Arab Emirates")
        let secondRecord = locationData(street: "China cluster", city: "international city", state:"Dubai", country: "united Arab Emirates")
        let thirdRecord = locationData(street: "Silicon gate 1", city: "Silicon Oasis", state: "Dubai", country: "United Arab Emirates")
        let fourthRecord = locationData(street: "Hor Ans 5", city: "Abu Hail", state:"Dubai", country: "united Arab Emirates")
        
 
        array.append( firstRecord)
        array.append( secondRecord)
        
        array.append( thirdRecord)
        array.append( fourthRecord)

        // Uncomment the following line to preserve selection between presentations
         self.clearsSelectionOnViewWillAppear = false

        // Register cell classes

        self.collectionView?.backgroundColor = .white
        
        // Register cell classes
        self.collectionView!.register(DestinationVCcell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView?.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        
        //to be
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addDetails))
        navigationItem.rightBarButtonItem = addButton
        // Do any additional setup after loading the view.
         view.addSubview(searchBar)
        searchBar.delegate = self
       searchBar.anchor(top: view.topAnchor, left: view.leftAnchor,right: view.rightAnchor, paddingTop: 60, paddingLeft: 10, paddingRight: 10)
    }

    override func viewDidDisappear(_ animated: Bool) {
        searchBar.text = ""
        isSearching = false
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
     
        return 1
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
      
    
        // Configure the cell
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! DestinationVCcell
        
        
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
            cell.streetLabel.text = filtered[indexPath.row].street

            
        }else {
             cell.streetLabel.text = array[indexPath.row].street

        }
        
       
       return cell
     
    }

    @objc func addDetails() {
        
        let detailVC = MyViewController()
       // detailVC.delegate = self
        detailVC.mode = .add
        navigationController?.pushViewController(detailVC, animated: true)
    }
//    func modify(record: MyData) {
//
//        let indexPath = collectionView?.indexPathsForSelectedItems
//
//        array.remove(at: indexPath![0].row)
//        array.append(record)
//        array.sort { $0.name < $1.name }
//        collectionView?.reloadData()
//    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        //   if kind == UICollectionView.elementKindSectionHeader {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath)
      
        
        return header
        // }
        
    }
    func  collectionView(_ collectionView: UICollectionView, layout collectionViewLayout : UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize{
        // return (CGSize(width: view.bounds.width, height: CGFloat(60)))
        return (CGSize(width: view.bounds.width, height: 60))
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return(CGSize(width: view.bounds.width, height: 50))
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        record3.stepCompleted = true
        record3.subTitle = array[indexPath.row].street
        
        
        record2.street = array[indexPath.row].city
        // record2.subTitle = " \(qrSeen.count) Medicine scanned"
        // record2.stepCompleted = true
        if mode == .add {
            delegate2?.add(record: record3)
        } else if mode == .edit {
            delegate2?.modify(record: record3)
            delegate2?.modify(record: record2)
        }
        else {
            print ("This Shouldn't Happen")
        }
        navigationController?.popViewController(animated: true)
        
    }

}
