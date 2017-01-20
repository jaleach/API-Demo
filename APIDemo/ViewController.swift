//
//  ViewController.swift
//  APIDemo
//
//  Created by James Leach on 1/12/17.
//  Copyright © 2017 Dadio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cityTextField: UITextField!
    
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBAction func submit(_ sender: AnyObject) {
        
        if let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=" + cityTextField.text!.replacingOccurrences(of: " ", with: "%20") + ",uk&appid=9dcf5689f5000af48987f711e1ea564e") {
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                
                print(error)
                
            } else {
                
                if let urlContent = data {
                    
                    do {
                        
                        let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers)
                        
                       print(jsonResult)
                        
                        // print(jsonResult["name"])
                        
                        
                        if let description = ((["weather"] as? NSArray)?[0]as? NSDictionary)?["description"]as? String {
                            
                            DispatchQueue.main.sync(execute: {
                                
                                self.resultLabel.text = description
                                
                            })
                            
                            
                        }
                        
                        
                    } catch {
                        
                        print("JSON Processing Failed")
                        
                    }
                    
                }
                
            }
            
        }
        
        task.resume()
        
        } else {
            
            resultLabel.text = "Couldn't find weather for that city - please try another."
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
            }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

