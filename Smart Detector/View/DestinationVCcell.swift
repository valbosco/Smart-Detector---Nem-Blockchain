//
//  DestinationVCcell.swift
//  Smart Detector
//
//  Created by Nnamdi Ugwuoke on 4/7/19.
//  Copyright © 2019 Manipal University Dubai. All rights reserved.
//

import UIKit

class DestinationVCcell: UICollectionViewCell {
    let iconImageView:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "ic_location")
        return iv
    }()
    var streetLabel: UILabel = {
        let label = UILabel()
        label.textColor = .blue
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "P11 france cluster"
        //label.alpha = 0
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpView()
        setUpContraints()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setUpView() {
        addSubview(iconImageView)
        addSubview(streetLabel)
     
        
        //       nameLabel.textAlignment = .center
    }
    func setUpContraints() {
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor,paddingTop: 5, paddingLeft: 5, paddingBottom: 5,  width: 40, height: 40)
        streetLabel.translatesAutoresizingMaskIntoConstraints = false
        streetLabel.anchor(top: topAnchor, left: iconImageView.rightAnchor, bottom: bottomAnchor, paddingTop: 5, paddingLeft: 5, paddingBottom: 5)
        
    }
    
}
