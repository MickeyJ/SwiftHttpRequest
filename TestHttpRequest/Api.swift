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
    
}
