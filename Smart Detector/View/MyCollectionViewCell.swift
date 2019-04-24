//
//  MyCollectionViewCell.swift
//  final


import UIKit

class MyCollectionViewCell: UICollectionViewCell {
    

    
    //mark: - properties
 
    let orderNumberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .blue
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "#7839398839993"
        return label
    }()
    let statusBtn: UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 0, y: 0, width: 350, height: 42)
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.white.cgColor
        button.titleLabel?.textColor = UIColor.white
        button.tintColor = UIColor.white
        button.layer.cornerRadius = 15.0
        button.setTitle("newly created", for: .normal)
        button.backgroundColor = UIColor.blue
        return button
    }()

    let addressLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Dubai, UAE"
        return label
    }()
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "Ayesha"
        return label
    }()
    let statusLabel: UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 0, y: 0, width: 300, height: 42)
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.white.cgColor
        button.titleLabel?.textColor = UIColor.white
        button.tintColor = UIColor.white
        button.layer.cornerRadius = 15.0
        button.setTitle("    Status     ", for: .normal)
        button.backgroundColor = UIColor.blue
        return button
    }()

 //   let nameLabel1 = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpView()
        setUpContraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView() {
        addSubview(nameLabel)
        addSubview(orderNumberLabel)
        addSubview(addressLabel)
        addSubview(statusBtn)
        //addSubview(statusLabel)
        nameLabel.textAlignment = .center
    }
    
    func setUpContraints() {
        //   Label
        
        //     Constrain to the Cell Margins
        
//        let labelLeft = NSLayoutConstraint(item: nameLabel, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1.0, constant: 0)
//        let labelTop = NSLayoutConstraint(item: nameLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0)
//        let labelRight = NSLayoutConstraint(item: nameLabel, attribute: .right, relatedBy: .equal, toItem: self , attribute: .right, multiplier: 1.0, constant: 0)
//        let labelBottom = NSLayoutConstraint(item: nameLabel, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        orderNumberLabel.anchor(top: topAnchor, left: leftAnchor,paddingTop: 20, paddingLeft: 16 )
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
             addressLabel.anchor(top: orderNumberLabel.bottomAnchor, left: leftAnchor,paddingTop: 16, paddingLeft: 16)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
          nameLabel.anchor(top: addressLabel.bottomAnchor, left: leftAnchor,paddingTop: 8, paddingLeft: 16)
        
        statusBtn.translatesAutoresizingMaskIntoConstraints = false
        
        statusBtn.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        statusBtn.anchor( right: rightAnchor, paddingRight: 16)
        statusBtn.anchor( paddingTop: 16, paddingLeft: 16, paddingBottom: 16, paddingRight: 16, width: 140, height: 30)
//        statusLabel.translatesAutoresizingMaskIntoConstraints = false
//
//        statusLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//        statusLabel.anchor( right: rightAnchor, paddingRight: 16)
        //self.addConstraints([labelTop, labelLeft, labelRight, labelBottom])
    }
    
    

}
