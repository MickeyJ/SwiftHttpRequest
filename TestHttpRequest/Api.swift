//
//  Utilities.swift
//  TestHttpRequest
//
//  Created by Michael Malotte on 11/13/16.
//  Copyright © 2016 Michael Malotte. All rights reserved.
//

import UIKit

class Api {
    
    static func configureRequest( url: URL, method: String, dataString: String? = nil ) -> URLRequest {
        
        var request = URLRequest(url: url)
        
        request.httpMethod = method
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        if dataString != nil {
            request.httpBody = dataString?.data(using: .utf8)
        }
        
        return request
    }
    
    static func sendRequest(request: URLRequest, then: @escaping (_ result: Data) -> Void) {
        
        let task = session.dataTask(with: request as URLRequest) {
            (data, response, error) in
            
            guard let data = data, error == nil else {
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            then(data)
        }
        
        task.resume()
        
    }
    
}
