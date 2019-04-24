//
//  MenuController.swift
//  Smart Detector
//
//  Created by Nnamdi Ugwuoke on 3/23/19.
//  Copyright © 2019 Manipal University Dubai. All rights reserved.
//

import UIKit

class MenuController : UIViewController{
    
    //mark: - properties
    var tableview : UITableView!
    var delegate: HomeControllerDelegate?
    private let reuseIdentifier = "menuOptionCell"
    //mark: - init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        configureTableView()
    }
    //mark: - Handlers
    func configureTableView(){
        tableview = UITableView()
        tableview.delegate = self
        tableview.dataSource = self
        
        tableview.register(MenuOptionCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableview.backgroundColor = .black
        tableview.separatorStyle = .none
        tableview.rowHeight = 80
        
        view.addSubview(tableview)
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableview.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableview.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableview.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
extension  MenuController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! MenuOptionCell
        let menuOption = MenuOption(rawValue: indexPath.row)
        cell.descriptionLabel.text = menuOption?.description
        cell.iconImageView.image = menuOption?.image
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          let menuOption = MenuOption(rawValue: indexPath.row)
        delegate?.handleMenuToggle(forMenuOption: menuOption)
    }
    
}
