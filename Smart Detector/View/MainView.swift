//
//  MainView.swift
//  ViewDemo


import UIKit
import AVFoundation

class MainView: UIView , AVCaptureMetadataOutputObjectsDelegate {
    var likeAction: (() -> Void)?
 var video = AVCaptureVideoPreviewLayer()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupViews()
       
        setupConstraints()
        // setupQRCode()
        addActions()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
       //self.addSubview(contentView)
      //  self.addSubview(likeButton)
    }

    func setupConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        setupContentViewConstraints()
        setupLikeButtonConstraints()
    }

    func addActions() {
        likeButton.addTarget(self, action: #selector(self.onLikeButton), for: .touchUpInside)
    }

    @objc func onLikeButton() {
        likeAction?()
    }

    fileprivate func setupContentViewConstraints() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        contentView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        contentView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
    }

    fileprivate func setupLikeButtonConstraints() {
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        likeButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0).isActive = true
        likeButton.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 10).isActive = true
    }

    let contentView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.lightGray.cgColor
        return view
    }()

    let likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Like", for: .normal)
        return button
    }()
    
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
        video.frame = CGRect(x: 0, y: 0, width: 500, height: 320)
        video.frame = contentView.layer.bounds
       // view.layer.addSublayer(video)
        session.startRunning()
        
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects.count != 0{
            if let object = metadataObjects[0] as? AVMetadataMachineReadableCodeObject{
                if object.type == AVMetadataObject.ObjectType.qr{
                    print(object)
                    let alert = UIAlertController(title: "QR Code", message: object.stringValue, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Retake", style: .default, handler: nil))
                    //                    alert.addAction(UIAlertAction(title: "Copy", style: .default, handler: { (nil) in
                    //                        UIPasteboard.general.string = object.stringValue
                    //                    }))
                    //present(alert, animated: true, completion: nil)
                }
                
            }
        }
    }
}
