//
//  ViewController.swift
//  TestHttpRequest
//
//  Created by Michael Malotte on 11/13/16.
//  Copyright © 2016 Michael Malotte. All rights reserved.
//

import UIKit
import Foundation

let session = URLSession.shared

class MainVC: UIViewController {
    
    @IBOutlet weak var getMessageLabel: UILabel!
    @IBOutlet weak var postMessageLabel: UILabel!
    @IBOutlet weak var postTextField: UITextField!
    
    var personCount: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func onGetAllPress(_ sender: Any) {
        
        let request = Api.configureRequest(pathname: "/array", method: "GET")
        
        Api.sendRequest(request: request, acceptStatus: 200, then: { result in
            
            let json = JSON.parseArray(data: result)
            
            self.personCount = json.count - 1
            
            let itemsMessage = json.count > 1 ? "items in array" : "item in array"
            
            DispatchQueue.main.async {
                self.getMessageLabel?.text = "Success! \(json.count) \(itemsMessage)."
            }
            
            for person in json {
                
                print("\(person["name"]!)")
                
            }
            
        })
        
    }
    
    @IBAction func onGetOnePress(_ sender: Any) {
        
        let request = Api.configureRequest(pathname: "/obj/\(personCount)", method: "GET")
        
        Api.sendRequest(request: request, acceptStatus: 200, then: { result in
            
            let json = JSON.parseObject(data: result)
            
            if let responseData = json, json != nil {
                
                print(responseData["message"]!)
                print("——————————————")
                print(responseData)
                print("——————————————")
                print("")
                
                let message = "\(responseData["message"]!) You got \(responseData["person"]!)"
                
                DispatchQueue.main.async {
                    self.getMessageLabel?.text = message
                }
                
            }
            
        })
        
    }
    
    @IBAction func onPostDataPress(_ sender: Any) {
        
        if postTextField.text! == "" { return }
        
        let person = postTextField.text!.capitalized
        let postName: String = "name=\(person)"
        let request = Api.configureRequest(pathname: "/obj", method: "POST", dataString: postName)
        
        postTextField.text = nil
        
        Api.sendRequest(request: request, acceptStatus: 201, then: { result in
            
            let json = JSON.parseObject(data: result)
            
            if let responseData = json, json != nil {
                
                print(responseData["message"]!)
                print("——————————————")
                print("")
                
                let message = "\(responseData["message"]!) You added \(person)"
                
                DispatchQueue.main.async {
                    self.postMessageLabel?.text = message
                }
                
            }
            
        })
        
    }

}

