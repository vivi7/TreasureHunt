//
//  JSon.swift
//  TreasureHunt
//
//  Created by Vincenzo Favara on 25/09/14.
//  Copyright (c) 2014 Vincenzo Favara. All rights reserved.
//

import Foundation

typealias JSON = AnyObject
typealias JSONDictionary = Dictionary<String, JSON>
typealias JSONArray = Array<JSON>

private func jsonDictionary(fromData: NSData?, error: NSErrorPointer) -> JSONDictionary? {
    if let data = fromData {
        var jsonErrorOptional: NSError?
        if let dict: AnyObject = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(0), error: &jsonErrorOptional) {
            return dict as? JSONDictionary
        }
    }
    
    return nil
}

public class JSONParser {
    private let _json: JSONDictionary?
    public let error: NSError?
    
    init() {
    }
    
    public init(_ data: NSData?) {
        if data != nil {
            self._json = jsonDictionary(data, &self.error)
        } else {
            self.error = NSError(domain: "com.vivi.TreasureHunt", code: 100, userInfo: [NSLocalizedDescriptionKey: "Parser did not have any data to parse"])
        }
    }
    
    public func get(path: String?) -> AnyObject? {
        return getFinalValue(_json, withPath: JSONPath(path) )
    }
    
    public func getString(path: String?) -> String? {
        return self.get(path) as? String
    }
    
    public func getInt(path: String?) -> Int? {
        return self.get(path) as? Int
    }
    
    public func getDouble(path: String?) -> Double? {
        return self.get(path) as? Double
    }
    
    public func getArray(path: String?) -> Array<AnyObject>? {
        return self.get(path) as? Array<AnyObject>
    }
    
    private func getFinalValue(json: JSON?, withPath path: JSONPath) -> JSON? {
        if json == nil { return nil }
        if let nextKey = path.popNext() {
            
            // Handle JSONArray type here
            // Get the value from the array and call recursively on the child
            if let (arrayKey, arrayIndex) = JSONPath.getArrayKeyAndIndex(nextKey) {
                if arrayKey != nil && arrayIndex != nil {
                    if let array = json![arrayKey!] as? JSONArray {
                        return getFinalValue(array[arrayIndex!] as JSON, withPath: path)
                    }
                }
            }
            
            if let value: AnyObject = json![nextKey] {
                return getFinalValue(value, withPath: path)
            } else {
                return nil
            }
        }
        
        return json
    }
}

class JSONPath {
    let path: String?
    var pathComponents = Array<String>()
    
    init(_ path: String?) {
        if let nsPath = path as NSString? {
            self.path = path
            pathComponents = nsPath.componentsSeparatedByString(".") as Array<String>
        }
    }
    
    func popNext() -> String? {
        if pathComponents.isEmpty { return nil }
        return pathComponents.removeAtIndex(0)
    }
    
    class func getArrayKeyAndIndex(optionalKey: String?) -> (String?, Int?)? {
        if let key = optionalKey as String? {
            var arrayKey: String?
            var arrayIndex: Int?
            var itr = 0
            
            //TODO: Match the key of the array and the index
/*
            for match in key =~ "\\w+(?=\\[)|(?<=\\w\\[)(\\d+)(?=\\])" { //I don't understad
                if (itr == 0) {
                    arrayKey = match
                } else {
                    arrayIndex = match.toInt()
                }
                ++itr
            }
*/
            return (arrayKey, arrayIndex)
        }
        
        return nil
    }
}