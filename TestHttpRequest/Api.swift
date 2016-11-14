//
//  Utilities.swift
//  TestHttpRequest
//
//  Created by Michael Malotte on 11/13/16.
//  Copyright © 2016 Michael Malotte. All rights reserved.
//

import UIKit

struct Api {
    
    private static let baseURL: String = "http://localhost:3000"
    
    static func configureRequest( pathname: String, method: String, dataString: String? = nil ) -> URLRequest {
        
        let url: URL = URL(string: "\(baseURL)\(pathname)")!
        
        var request = URLRequest(url: url)
        
        request.httpMethod = method
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        if dataString != nil {
            request.httpBody = dataString?.data(using: .utf8)
        }
        
        return request
    }
    
    static func sendRequest(request: URLRequest, acceptStatus: Int, then: @escaping (_ result: Data) -> Void) {
        
        let task = session.dataTask(with: request as URLRequest) {
            (data, response, error) in
            
            guard let data = data, error == nil else {
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != acceptStatus {
                print("statusCode should be \(acceptStatus), but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            then(data)
        }
        
        task.resume()
        
    }
    
}
