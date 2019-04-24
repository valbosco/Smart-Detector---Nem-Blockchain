//
//  MedicineList+Search.swift
//  Smart Detector
//
//  Created by Nnamdi Ugwuoke on 4/17/19.
//  Copyright © 2019 Manipal University Dubai. All rights reserved.
//
import UIKit
extension MedicineViewController: UISearchBarDelegate{
    public func searchBarTextDidBeginEditing(_ searchBar: UISearchBar){
        isSearching = true
    }
    
    public func searchBarTextDidEndEditing(_ searchBar: UISearchBar)
    {
        isSearching = false
    }
    
    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar){
        isSearching = false
    }
    
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        isSearching = false
    }
    
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        
        filtered.removeAll(keepingCapacity: false)
        let predicatedString =  searchBar.text!
        
        filtered = array.filter( {$0.name.range(of: predicatedString) != nil} )
        filtered.sort {$0.name < $1.name}
        
        isSearching = (filtered.count == 0 ) ? false: true
        
        // print(filtered)
        //print(isSearching)
        collectionView?.reloadData()
        
    }

    
}
