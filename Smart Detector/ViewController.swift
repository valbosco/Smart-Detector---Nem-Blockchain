//
//  ViewController.swift
//  Smart Detector
//
//  Created by Nnamdi Ugwuoke on 2/20/19.
//  Copyright © 2019 Manipal University Dubai. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
var video = AVCaptureVideoPreviewLayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupQRCode()
    }
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
        video.frame = view.layer.bounds
        view.layer.addSublayer(video)
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
                    present(alert, animated: true, completion: nil)
                }
                
            }
        }
    }

}

