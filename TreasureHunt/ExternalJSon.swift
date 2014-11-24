//
//  ExternalJSon.swift
//  TreasureHunt
//
//  Created by Vincenzo Favara on 25/09/14.
//  Copyright (c) 2014 Vincenzo Favara. All rights reserved.
//

import Foundation

var data: NSMutableData = NSMutableData()

func getConnection(urlPath : String){
    
    let url: NSURL = NSURL(string: urlPath)!
    
    var request: NSURLRequest = NSURLRequest(URL: url)
    var connection: NSURLConnection = NSURLConnection(request: request, delegate: AppDelegate.self, startImmediately: false)!
}

func connection(didReceiveResponse: NSURLConnection!, didReceiveResponse response: NSURLResponse!) {
    // Recieved a new request, clear out the data object
    data = NSMutableData()
}

func connection(connection: NSURLConnection!, didReceiveData dataR: NSData!) {
    // Append the recieved chunk of data to our data object
    data.appendData(dataR)
}