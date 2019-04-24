//
//  CarrierVCcell.swift
//  Smart Detector
//
//  Created by Nnamdi Ugwuoke on 4/7/19.
//  Copyright © 2019 Manipal University Dubai. All rights reserved.
//

import UIKit

class CarrierVCcell: UICollectionViewCell {
    let iconImageView:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "account_circle_grey_192x192")
        return iv
    }()
    let rating:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "3.5 rating")
        return iv
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .blue
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Mohammed Ali"
        //label.alpha = 0
        return label
    }()
    var subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .blue
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "32 Abu Hail metro station"
        //label.alpha = 0 ic_forwardarrowblack
        return label
    }()
    var deliveriesNoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .blue
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Deliveries: O"
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
        addSubview(rating)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(deliveriesNoLabel)
        
        
        //       nameLabel.textAlignment = .center
    }
    func setUpContraints() {
 iconImageView.translatesAutoresizingMaskIntoConstraints = false
iconImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, width: 40, height: 40)
  titleLabel.translatesAutoresizingMaskIntoConstraints = false
   titleLabel.anchor(top: topAnchor, left: iconImageView.rightAnchor, paddingTop: 10, paddingLeft: 5)
subtitleLabel.anchor(top: titleLabel.bottomAnchor, left: iconImageView.rightAnchor, paddingTop: 5, paddingLeft: 5)
deliveriesNoLabel.translatesAutoresizingMaskIntoConstraints = false
        deliveriesNoLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        deliveriesNoLabel.anchor( right: rightAnchor,  paddingRight: 10)
    rating.translatesAutoresizingMaskIntoConstraints = false
        rating.anchor(top: subtitleLabel.bottomAnchor, left: iconImageView.rightAnchor,paddingTop: 5,  width: 75, height: 15)
    }
    
    
}
