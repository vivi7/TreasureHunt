//
//  ViewController.swift
//  TreasureHunt
//
//  Created by Vincenzo Favara on 23/09/14.
//  Copyright (c) 2014 Vincenzo Favara. All rights reserved.
//

import UIKit
//import Foundation
//import AVFoundation


class ViewController: UIViewController , DetailsDelegate {
    
    @IBOutlet var currentPoint : UILabel!
    
    @IBOutlet var clueImage : UIImageView!
    
    @IBOutlet var currentClue : UILabel!
    
    @IBOutlet weak var label: UILabel!
    
    //let driveService : GTLService =  GTLService()
/*
    let kKeychainItemName : NSString = "Google Plus Quickstart"
    let kClientID : NSString = "875676980107-2cf2c876g3guuupalb9bjbig4s0n9kjq.apps.googleusercontent.com"
    let kClientSecret : NSString = "e2fvmIcKUh7GMjU6C3KUUcen"
    
    
    var num : Int = 0;
    
    let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
    let session = AVCaptureSession()
    var layer: AVCaptureVideoPreviewLayer?
*/
    
    func labelDelegateMethodWithString(string: String) {
        label.text = string
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Treasure Hunt"
        currentPoint.text = self.title
        
      //  driveService = GTMOAuth2ViewControllerTouch.authForGoogleFromKeychainForName(kKeychainItemName,
        //    clientID: kClientID,
          //  clientSecret: kClientSecret)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func callScan(buttonTapped: UIButton){
        
        //currentClue.text = "Scan Qr Code "
/*
        self.view.backgroundColor = UIColor.grayColor()
        currentClue = UILabel(frame:CGRectMake(15, 80, 290, 50))
        currentClue.backgroundColor = UIColor.clearColor()
        currentClue.numberOfLines = 2
        currentClue.textColor = UIColor.whiteColor()
        self.view.addSubview(currentClue)
        let imageView = UIImageView(frame:CGRectMake(10, 140, 300, 300))
        imageView.image = UIImage(named:"pick_bg")
        self.view.addSubview(imageView)
*/
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        let controller = segue.destinationViewController as QrViewController
        controller.delegate = self
    }

    /*
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.setupCamera()
        self.session.startRunning()
    }
    
    func setupCamera(){
        self.session.sessionPreset = AVCaptureSessionPresetHigh
        var error : NSError?
        let input = AVCaptureDeviceInput(device: device, error: &error)
        if (error != nil) {
            println(error?.description)
            return
        }
        if session.canAddInput(input) {
            session.addInput(input)
        }
        layer = AVCaptureVideoPreviewLayer(session: session)
        layer!.videoGravity = AVLayerVideoGravityResizeAspectFill
        layer!.frame = CGRectMake(20,150,280,280);
        self.view.layer.insertSublayer(self.layer, atIndex: 0)
        let output = AVCaptureMetadataOutput()
        output.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        if session.canAddOutput(output) {
            session.addOutput(output)
            output.metadataObjectTypes = [AVMetadataObjectTypeQRCode];
        }
        
        session.startRunning()
    }
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!){
        var stringValue:String?
        if metadataObjects.count > 0 {
            var metadataObject = metadataObjects[0] as AVMetadataMachineReadableCodeObject
            stringValue = metadataObject.stringValue
        }
        self.session.stopRunning()
        println("code is \(stringValue)")
        
        //        let alertController = UIAlertController(title: "title1", message: "message0:\(stringValue)", preferredStyle: UIAlertControllerStyle.Alert)
        //        alertController.addAction(UIAlertAction(title: "title2", style: UIAlertActionStyle.Default, handler: nil))
        //        self.presentViewController(alertController, animated: true, completion: nil)
        var alertView = UIAlertView()
        alertView.delegate=self
        alertView.title = "title3"
        alertView.message = "message1:\(stringValue)"
        alertView.addButtonWithTitle("title4")
        alertView.show()
    }
*/
}

