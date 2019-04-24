//
//  MedicineListCell.swift
//  Smart Detector
//
//  Created by Nnamdi Ugwuoke on 4/17/19.
//  Copyright © 2019 Manipal University Dubai. All rights reserved.
//

import UIKit

class MedicineListCell: UICollectionViewCell {
      var addToCart: Bool = false
    let iconImageView:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "malaria injection")
        return iv
    }()
    let addToCartButton:UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 0, y: 0, width: 220, height: 42)
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.white.cgColor
        button.titleLabel?.textColor = UIColor.white
        button.tintColor = UIColor.white
        button.layer.cornerRadius = 15.0
        button.setTitle(" add to cart ", for: .normal)
        button.addTarget(self, action: #selector(handleAddtoCart), for: .touchUpInside)
        button.backgroundColor = UIColor.blue
        return button
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
        let view = UIView(frame: CGRect(x: 0, y:0, width: 30, height: 20))
        view.backgroundColor = .yellow
        let label = UILabel()
        label.textColor = .yellow
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "Now"
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
        addSubview(addToCartButton)
        //addSubview(arrorIconImageView)
        
        //       nameLabel.textAlignment = .center
    }
    @objc func handleAddtoCart(){
//        if addToCart {
//            addToCart = false
//            addToCartButton.setTitle("add to Cart", for: .normal)
//            addToCartButton.backgroundColor = .blue
//           
//        }else{
//            addToCart = true
//            addToCartButton.setTitle("added to Cart", for: .normal)
//            addToCartButton.backgroundColor = .yellow
//        }
//        
    }
    func setUpContraints() {

        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.anchor(top: topAnchor, left: leftAnchor , paddingTop:30,paddingLeft:5, width: 50, height: 40)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.anchor(top: topAnchor, left: iconImageView.rightAnchor, paddingLeft: 30)
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.anchor(top: titleLabel.bottomAnchor, left: iconImageView.rightAnchor,paddingTop: 5, paddingLeft: 30)
        addToCartButton.anchor(top:  subtitleLabel.bottomAnchor, left: iconImageView.rightAnchor,paddingTop: 10, paddingLeft: 10)
       
    //addToCartButton.translatesAutoresizingMaskIntoConstraints = false
  //  addToCartButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
      //  addToCartButton.anchor( right: rightAnchor, paddingRight: 16, width: 40, height: 40)


    }

    /*
    func setUpContraints() {
        numberContainerView.translatesAutoresizingMaskIntoConstraints = false
        numberContainerView.anchor(top: topAnchor, left: leftAnchor, width: 20, height: 100)
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.anchor(top: topAnchor, left: numberContainerView.rightAnchor, bottom: bottomAnchor, paddingTop: 30, paddingLeft: 30, paddingBottom: 30,  width: 50, height: 50)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.anchor(top: topAnchor, left: iconImageView.rightAnchor, paddingTop: 30, paddingLeft: 30)
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.anchor(top: titleLabel.bottomAnchor, left: iconImageView.rightAnchor,paddingTop: 5, paddingLeft: 30)
      //  arrorIconImageView.translatesAutoresizingMaskIntoConstraints = false
      //  arrorIconImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
       // arrorIconImageView.anchor( right: rightAnchor, paddingRight: 16, width: 40, height: 40)
        
        
    }
    */
}
