//
//  Utils.swift
//  TestHttpRequest
//
//  Created by Michael Malotte on 11/13/16.
//  Copyright © 2016 Michael Malotte. All rights reserved.
//

import Foundation


struct JSON {
    
    static func parseObject(data: Data) -> [String: Any]? {
        
        do {
            
            return try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as? [String: Any]
            
        } catch {
            
            return nil
            
        }
    }
    
    static func parseArray(data: Data) -> Array<[String: Any]> {
        
        do {
            
            return try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as! Array<[String: Any]>
            
        } catch {
            
            return []
            
        }
    }
    
}
