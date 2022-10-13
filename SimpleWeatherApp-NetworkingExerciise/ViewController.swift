//
//  ViewController.swift
//  SimpleWeatherApp-NetworkingExerciise
//
//  Created by Clayville on 13/10/2022.
//  Copyright © 2022 Clayton Nyamudzarumbu. All rights reserved.
//  Follow me on Twitter: @ilostmykeys_
    

import UIKit

class ViewController: UIViewController {
    // 1. Request
    // 2. Response and receive the data
    // 3. Process the data (JSON deserialization)
    // 4. Resume
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func getDataClicked(_ sender: UIButton) {
        
        let urlString = "http://api.weatherstack.com/current?access_key=224a0b21ebf6db6c836e4e7dd9ab7f57&query=DOHA"
        
        let url = URL(string: urlString)
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { (data, response, error) in
            if error != nil{
                print("ERROR OCCURED WHILE FETCHING DATA")
            } else {
                if data != nil{
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! Dictionary<String,Any>
                        
                        DispatchQueue.main.async {
                            print(jsonResponse)
                            
                            if let current = jsonResponse["current"] as? [String: Any]{
                                
                                if let desc = current["weather_descriptions"] as? NSArray{
                                    self.resultLabel.text = desc[0] as? String
                                }
                            }
                        }
                    } catch {
                        
                        print(error.localizedDescription)
                        print("Error in JSONDeserialization")
                    }
                }
            }
        }
        task.resume()
    }
}

