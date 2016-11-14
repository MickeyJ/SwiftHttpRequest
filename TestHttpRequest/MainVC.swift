//
//  ViewController.swift
//  TestHttpRequest
//
//  Created by Michael Malotte on 11/13/16.
//  Copyright © 2016 Michael Malotte. All rights reserved.
//

import UIKit
import Foundation

let getUrl:URL = URL(string: "http://localhost:3000/")!
let postUrl:URL = URL(string: "http://localhost:3000/post")!
let session = URLSession.shared

class MainVC: UIViewController {
    
    @IBOutlet weak var getMessageLabel: UILabel!
    @IBOutlet weak var postMessageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func onGetDataPress(_ sender: Any) {
        getData()
    }
    
    @IBAction func onPostDataPress(_ sender: Any) {
        postData()
    }
    
    func getData(){
        
        let request = Api.configureRequest(url: getUrl, method: "GET")
        
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
            
            let json = Utils.jsonParseObject(data: data)
            
            if let responseData = json, json != nil {
                
                print(responseData["message"]!)
                print("——————————————")
                print("")
                
                DispatchQueue.main.async {
                    self.getMessageLabel?.text = responseData["message"] as! String?
                }
                
            }
            
        }
        
        task.resume()
    }
    
    func postData(){
        
        let request = Api.configureRequest(url: postUrl, method: "POST", dataString: "id=1&name=joe")
        
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
            
            let json = Utils.jsonParseObject(data: data)
            
            if let responseData = json, json != nil {
                
                print(responseData["message"]!)
                print("——————————————")
                print("")
                
                DispatchQueue.main.async {
                    self.postMessageLabel?.text = responseData["message"] as! String?
                }
                
            }
            
        }
        
        task.resume()
    }

}

