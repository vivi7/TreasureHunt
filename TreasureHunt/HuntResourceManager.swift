//
//  HuntResourceManager.swift
//  TreasureHunt
//
//  Created by Vincenzo Favara on 25/09/14.
//  Copyright (c) 2014 Vincenzo Favara. All rights reserved.
//

import Foundation

class HuntResourceManager {
    var huntJSON:String = "";
    
    func unzipFile() {
        //TODO: unzip file
    }
    
    func getJSon() -> NSString {
        let p1  =   "//any.json"
        let d1  =   NSData(contentsOfFile: p1)
        let a1 : AnyObject! =   NSJSONSerialization.JSONObjectWithData(d1!, options: NSJSONReadingOptions(0), error: nil)

        return huntJSON
    }
    
    

}
