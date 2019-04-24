//
//  SettingsController.swift
//  Smart Detector
//
//  Created by Nnamdi Ugwuoke on 3/25/19.
//  Copyright © 2019 Manipal University Dubai. All rights reserved.
//

import UIKit
private let reuseIdentifier = "SettingsCell"

class SettingsController : UIViewController {
    //Mark: - Properties
    
    var tableView: UITableView!
    var userInfoHeader: UserInfoHeader!
    
    var username : String?
    //Mark: - Init
    override func viewDidLoad() {
          super.viewDidLoad()
        configureUI()
        if let username = username{
            print(username)
        }
    }
    //Mark: -Selectors
   @objc func handleDismiss(){
        dismiss(animated: true, completion: nil)
    }
    //Mark: -Helper functions
    func configureTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 60
        
        tableView.register(SettingsCell.self, forCellReuseIdentifier: reuseIdentifier)
        view.addSubview(tableView)
        tableView.frame = view.frame
        
        let frame = CGRect(x: 0, y: 88, width: view.frame.width, height: 100)
        userInfoHeader = UserInfoHeader(frame: frame)
        tableView.tableHeaderView = userInfoHeader
        tableView.tableFooterView = UIView()
    }
    
    
    func configureUI(){
        configureTableView()
        view.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = .black
         navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Settings"
        
        navigationController?.navigationBar.barStyle = .black
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "baseline_clear_white_36pt_3x.png")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleDismiss))
        
    }
    //Mark: -Handler
    
    
    
}

extension SettingsController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return SettingsSection.allCases.count;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = SettingsSection(rawValue: section) else { return 0 }
        
        switch section {
        case .Social: return SocialOptions.allCases.count
        case .Communications: return CommunicationOptions.allCases.count
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       let view = UIView()
        view.backgroundColor = .blue
        let title = UILabel()
        title.font = UIFont.boldSystemFont(ofSize: 16)
        title.textColor = .white
        title.text = SettingsSection(rawValue: section)?.description
        view.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        title.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
      
       
        return view
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SettingsCell
        guard let section = SettingsSection(rawValue: indexPath.section) else { return UITableViewCell() }
        
        switch section {
        case .Social:
            let social = SocialOptions(rawValue: indexPath.row)
            //cell.textLabel?.text = social?.description
            cell.sectionType = social
        case .Communications:
            let communications = CommunicationOptions(rawValue: indexPath.row)
            // cell.textLabel?.text = communications?.description
            cell.sectionType = communications
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let section = SettingsSection(rawValue: indexPath.section) else { return }
        
        switch section {
        case .Social:
            print(SocialOptions(rawValue: indexPath.row)?.description)
        case .Communications:
            print(CommunicationOptions(rawValue: indexPath.row)?.description)
        }
    }
}
