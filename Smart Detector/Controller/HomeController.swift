//
//  HomeController.swift
//  Smart Detector
//
//  Created by Nnamdi Ugwuoke on 3/23/19.
//  Copyright © 2019 Manipal University Dubai. All rights reserved.
//

import UIKit
import Firebase
import AVFoundation
   var counter: Int = 0

class HomeController : UIViewController{
      var refDb: DatabaseReference!
    var  record = MyData()
    var record2 = NewOrder()
    //mark: - properties
   // let presenter: MainViewPresenter!
  //  var mainView: MainView { return self.view as! MainView }
    
    var  mode: Mode!
   // var  delegate2: MyCollectionViewController!
    var qrSeen = Set<String>() {
        didSet {
            totalMedicationsLabel.text =  "Total: \(qrSeen.count)"
           
        }
    }
    var qrArray: [String] = []
   
//    var qrArray: [String] = []{
//        didSet {
//            totalMedicationsLabel.text =  "Total: \(qrArray.count)"
//        }
//
//    }
    weak var txtViewQr: UITextView!
    var video = AVCaptureVideoPreviewLayer()
    var delegate: HomeControllerDelegate?
    var  delegate2: NewDeliveryCollectionVC?
      var tableview : UITableView!
        private let reuseIdentifier = "qrCodeOptionCell"
    private let reuseIdentifier2 = "qrCodeOptionCell"
    var scanMedicationsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .blue
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Scanned Medications"
        //label.alpha = 0
        return label
    }()
    var totalMedicationsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .blue
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Total: \(counter)"
        //label.alpha = 0
        return label
    }()
    
    let qriconImageView:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "qrcodeIcon")
        return iv
    }()
    
    var scanQRCodeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .blue
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Scan QRCode"
        //label.alpha = 0
        return label
    }()
    let finishButton: UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 0, y: 0, width: 300, height: 42)
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.white.cgColor
        button.titleLabel?.textColor = UIColor.white
        button.tintColor = UIColor.white
        button.layer.cornerRadius = 15.0
        button.setTitle("     Accept     ", for: .normal)
        button.addTarget(self, action:  #selector(finishBtnClicked), for: .touchUpInside)
        button.backgroundColor = UIColor.blue
        return button
    }()
    let contentView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y:0, width: 360, height: 260))
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 1.0
      //  view.layer.borderColor = UIColor.red.cgColor
       view.translatesAutoresizingMaskIntoConstraints = false
//        view.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
//        view.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 10).isActive = true
//        view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
//        view.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 10).isActive = true
        return view
    }()
    
    fileprivate func setupContentViewConstraints() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 65).isActive = true
        contentView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        contentView.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: 55).isActive = true
    }
    //mark: - init
    
//    init(with presenter: MainViewPresenter) {
//
//
//        super.init(nibName: nil, bundle: nil)
//         self.presenter = presenter
//
//    }
    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(contentView)
        setupContentViewConstraints()
        
        //configureNavigationBar()
        configureTableView()
       // mainView.likeAction = { [weak self] in self?.likeAction() }
       
        setupQRCode()
        configureLabels()
    }
    
//    private func likeAction() {
//        presenter.updateLike()
//        
//        UIView.animate(withDuration: 0.5, animations: {
//            self.mainView.likeButton.setTitle(self.presenter.likeButtonTitle, for: .normal)
//            self.mainView.contentView.backgroundColor = self.presenter.viewColor
//        })
//    }
//
//    override func loadView() {
//       // self.view = MainView(frame: UIScreen.main.bounds)
//    }
     //mark: - Handlers
    @objc func handleMenuToggle(){
        delegate?.handleMenuToggle(forMenuOption: nil)
    }
    @objc func finishBtnClicked(){
        let orderNumber = record.orderNumber
        let uid = record.userId
        let key = record.orderNumber
        let name = record.name
        let phone = ""
        let address = record.address
        let medList = ["panadol"]
        
     let   values = ["userId": uid, "txnId": key, "name": name, "phone": phone, "address": address,"progress": "completed", "medList" : medList] as [String : Any]
        //refDb = Database.database().reference().child("orders")
        let controller =  SendXemViewController()
        
        self.present(UINavigationController(rootViewController: controller), animated: true, completion: nil)
        
        alertTheUser(title: " Transaction Accepted", message: "Thank you, please rate the logistics services")
          refDb = Database.database().reference().child("orders").child(orderNumber)
        
        alertTheUser(title: "About to Confirm transaction", message: "This transaction is about to be confirmed")
        refDb.updateChildValues(values, withCompletionBlock: { (error, ref) in
            if let error = error {
                print("Failed to update database values with error: ", error.localizedDescription)
                return
            }
           
        })
        
       // refDb.setValue("completed")
        
        
//        record2.subTitle = " \(qrSeen.count) Medicine scanned"
//        record2.stepCompleted = true
//        if mode == .add {
//            delegate2?.add(record: record2)
//        } else if mode == .edit {
//            delegate2?.modify(record: record2)
//        }
//        else {
//            print ("This Shouldn't Happen")
//        }
//        navigationController?.popViewController(animated: true)
    }
    func signOut() {
        do {
            try Auth.auth().signOut()
            let navController = UINavigationController(rootViewController: LoginController())
            navController.navigationBar.barStyle = .black
            self.present(navController, animated: true, completion: nil)
        } catch let error {
            print("Failed to sign out with error..", error)
        }
    }
    // MARK: - API
    
//    func loadUserData1() {
//
//          guard let uid = Auth.auth().currentUser?.uid else { return }
//        Database.database().reference().child("users").child(uid).child("username").observeSingleEvent(of: .value) { (snapshot) in
//            guard let username = snapshot.value as? String else { return }
//            self.welcomeLabel.text = "Welcome, \(username)"
//
//            UIView.animate(withDuration: 0.5, animations: {
//                self.welcomeLabel.alpha = 1
//            })
//        }
//    }

    
    //Mark: - selector
    @objc func saveRecord() {
        
        if mode == .add {
            delegate2?.add(record: record2)
        } else if mode == .edit {
            delegate2?.modify(record: record2)
        }
        else {
            print ("This Shouldn't Happen")
        }
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleSignOut() {
        let alertController = UIAlertController(title: nil, message: "Are you sure you want to sign out?", preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Sign Out", style: .destructive, handler: { (_) in
            self.signOut()
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    func configureNavigationBar(){
        navigationController?.navigationBar.barTintColor = .blue
        navigationController?.navigationBar.barStyle = .black
        navigationItem.title = "Doctors"
        
 
         navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_person_outline_white_2x.png")!.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleSignOut))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_menu_white_3x").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMenuToggle))
        
    }
    
    //mark: - Handlers
    func configureTableView(){
        tableview = UITableView()
        tableview.delegate = self
        tableview.dataSource = self
        
        tableview.register(QRCodeCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableview.backgroundColor = .white
        //tableview.separatorStyle = .none
        tableview.rowHeight = 40
        
        view.addSubview(tableview)
        view.addSubview(qriconImageView)
        view.addSubview(scanQRCodeLabel)
        view.addSubview(finishButton)
        view.addSubview(scanMedicationsLabel)
        view.addSubview(totalMedicationsLabel)
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        tableview.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        tableview.topAnchor.constraint(equalTo: scanMedicationsLabel.topAnchor, constant: 30).isActive = true
        tableview.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    func configureLabels(){
       
        
        scanMedicationsLabel.translatesAutoresizingMaskIntoConstraints = false
        scanMedicationsLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
     //scanMedicationsLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
       scanMedicationsLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 280).isActive = true
      // scanMedicationsLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        
        
        totalMedicationsLabel.translatesAutoresizingMaskIntoConstraints = false
       // totalMedicationsLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        totalMedicationsLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
       totalMedicationsLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 290).isActive = true
        //totalMedicationsLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        
         qriconImageView.translatesAutoresizingMaskIntoConstraints = false
        qriconImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
         qriconImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        
        
        
        scanQRCodeLabel.translatesAutoresizingMaskIntoConstraints = false
        scanQRCodeLabel.leftAnchor.constraint(equalTo: qriconImageView.rightAnchor, constant: 16).isActive = true
        scanQRCodeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        
        finishButton.translatesAutoresizingMaskIntoConstraints = false
        finishButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        finishButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
    }
    
}
extension HomeController : AVCaptureMetadataOutputObjectsDelegate{
    func setupQRCode(){
        // Do any additional setup after loading the view, typically from a nib.
        //create session
        let session = AVCaptureSession()
        //Define capture Device
        let captureDevice = AVCaptureDevice.default(for: .video)
        do{
            let input = try AVCaptureDeviceInput(device:captureDevice!)
            session.addInput(input)
        }catch{
            print("error")
        }
        let output = AVCaptureMetadataOutput()
        session.addOutput(output)
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        video = AVCaptureVideoPreviewLayer(session: session)
        //video.frame = CGRect(x: -200, y: 0, width: 700, height: 280)
    video.frame = contentView.bounds
       contentView.layer.addSublayer(video)
        session.startRunning()
        
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects.count != 0{
            if let object = metadataObjects[0] as? AVMetadataMachineReadableCodeObject{
                if object.type == AVMetadataObject.ObjectType.qr{
                    print(object)
                    for object in metadataObjects {
                        if let readableObject = object as? AVMetadataMachineReadableCodeObject,
                            let value = readableObject.stringValue {
                            print(value)
                          //  qrArray += [value.madeUnique(withRespectTo: qrArray )]
                         //   qrArray.append(value.madeUnique(withRespectTo: qrArray ))
                           
                            qrSeen.insert(value)
                             qrArray = Array(qrSeen)
                            tableview.reloadData()
                        }
                    }
                    print("--------")
                    print(qrSeen)
                   // print(qrArray)
                    let alert = UIAlertController(title: "QR Code", message: object.stringValue, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Retake", style: .default, handler: nil))
                                       alert.addAction(UIAlertAction(title: "Reset ", style: .default, handler: { (nil) in
                                        self.qrSeen.removeAll()
                    //                        UIPasteboard.general.string = object.stringValue
                                  }))
                    //present(alert, animated: true, completion: nil)
                }
                
            }
        }
    }
}

extension  HomeController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return qrSeen.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! QRCodeCell
        //let menuOption = MenuOption(rawValue: indexPath.row)
//        for qrSeenString
//           in qrSeen {
//            DispatchQueue.main.async {
//              cell.descriptionLabel.text = qrSeenString
//            }
//           // print(number)
//        }
     cell.descriptionLabel.text = qrArray[indexPath.row]
       // cell.iconImageView.image = menuOption?.image
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // let menuOption = MenuOption(rawValue: indexPath.row)
        //delegate?.handleMenuToggle(forMenuOption: menuOption)
}
    private func alertTheUser(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(ok)
        self.present(alert, animated: false, completion: nil)
    }
}
