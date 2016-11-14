//
//  ViewController.swift
//  TestHttpRequest
//
//  Created by Michael Malotte on 11/13/16.
//  Copyright © 2016 Michael Malotte. All rights reserved.
//

import UIKit
import Foundation

let getObjUrl:URL = URL(string: "http://localhost:3000/get/obj")!
let postObjUrl:URL = URL(string: "http://localhost:3000/post/obj")!

let getArrUrl:URL = URL(string: "http://localhost:3000/get/array")!
let postArrUrl:URL = URL(string: "http://localhost:3000/post/array")!

let session = URLSession.shared

class MainVC: UIViewController {
    
    @IBOutlet weak var getMessageLabel: UILabel!
    @IBOutlet weak var postMessageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func onGetDataPress(_ sender: Any) {
        getDataArray()
    }
    
    @IBAction func onPostDataPress(_ sender: Any) {
        postDataObject()
    }
    
    func getDataArray(){
        
        let request = Api.configureRequest(url: getArrUrl, method: "GET")
        
        Api.sendRequest(request: request, then: { result in
            
            let json = Utils.jsonParseArray(data: result)
            
            for data in json {
                
                if let person = data as? [String: Any] {
                    print("\(person["name"]!)")
                }
                
            }

        })
    }
    
    func getDataObject(){
        
        let request = Api.configureRequest(url: getObjUrl, method: "GET")
        
        Api.sendRequest(request: request, then: { result in
            
            let json = Utils.jsonParseObject(data: result)
            
            if let responseData = json, json != nil {
                
                print(responseData["message"]!)
                print("——————————————")
                print("")
                
                DispatchQueue.main.async {
                    self.getMessageLabel?.text = responseData["message"] as! String?
                }
                
            }
            
        })
        
    }
    
    func postDataObject(){
        
        let request = Api.configureRequest(url: postObjUrl, method: "POST", dataString: "name=suzy")
        
        Api.sendRequest(request: request, then: { result in
            
            let json = Utils.jsonParseObject(data: result)
            
            if let responseData = json, json != nil {
                
                print(responseData["message"]!)
                print("——————————————")
                print("")
                
                DispatchQueue.main.async {
                    self.postMessageLabel?.text = responseData["message"] as! String?
                }
                
            }
            
        })
    }

}

