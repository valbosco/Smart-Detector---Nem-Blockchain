//
//  NewDeliveryCell.swift
//  Smart Detector
//
//  Created by Nnamdi Ugwuoke on 4/5/19.
//  Copyright © 2019 Manipal University Dubai. All rights reserved.
//

import UIKit

class NewDeliveryCell: UICollectionViewCell {
    
    let iconImageView:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "qrcodeIcon")
        return iv
    }()
    let arrorIconImageView:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "ic_forwardarrowblack")
        return iv
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .blue
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Medicines"
        //label.alpha = 0
        return label
    }()
    var subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .blue
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0 medicines"
        //label.alpha = 0 ic_forwardarrowblack
        return label
    }()
   lazy var numberContainerView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y:0, width: 100, height: 100))
    view.backgroundColor = .blue
    let label = UILabel()
    label.textColor = .white
    label.font = UIFont.systemFont(ofSize: 20)
    label.text = "1"
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .center
    view.addSubview(label)
    //label.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 20, paddingRight: 20)
       // view.layer.borderColor = UIColor.lightGray.cgColor
        //view.layer.borderWidth = 1.0
        //  view.layer.borderColor = UIColor.red.cgColor


    label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    //view.addSubview(label)
   return view
    
    
    
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
       addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(numberContainerView)
        addSubview(arrorIconImageView)
        
//       nameLabel.textAlignment = .center
    }
    func setUpContraints() {
        numberContainerView.translatesAutoresizingMaskIntoConstraints = false
        numberContainerView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, width: 20, height: 100)
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.anchor(top: topAnchor, left: numberContainerView.rightAnchor, bottom: bottomAnchor, paddingTop: 30, paddingLeft: 30, paddingBottom: 30,  width: 50, height: 50)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.anchor(top: topAnchor, left: iconImageView.rightAnchor, paddingTop: 30, paddingLeft: 30)
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.anchor(top: titleLabel.bottomAnchor, left: iconImageView.rightAnchor,paddingTop: 5, paddingLeft: 30)
          arrorIconImageView.translatesAutoresizingMaskIntoConstraints = false
        arrorIconImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        arrorIconImageView.anchor( right: rightAnchor, paddingRight: 16, width: 40, height: 40)
        
        
    }
    
}
