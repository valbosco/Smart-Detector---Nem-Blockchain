//
//  QRCodeCell.swift
//  Smart Detector
//
//  Created by Nnamdi Ugwuoke on 3/30/19.
//  Copyright © 2019 Manipal University Dubai. All rights reserved.
//

import UIKit

class QRCodeCell: UITableViewCell {
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = "sample text"
        return label
    }()
    //mark: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
      //  backgroundColor = .white
        selectionStyle = .none
  
        addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 12).isActive = true
   
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
