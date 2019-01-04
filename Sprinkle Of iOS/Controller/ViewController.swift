//
//  ViewController.swift
//  Sprinkle Of iOS
//
//  Created by Dvontre Coleman on 1/3/19.
//  Copyright © 2019 Dvontre A Coleman. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    // variable to save the url for the api call
    let url : String = "https://sprinkle-of-jeezy.herokuapp.com/api/quotes"
    
    let quoteModel = QuoteModel()
    
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var songLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func getQuoteButtonBressed(_ sender: Any) {
        // Calls a function to get data from API
        getApiData()
    }
    
    func getApiData(){
        print("Were getting closer")
        // use Alamofire to get data from api
        Alamofire.request(url).responseJSON{
            response in
            if response.result.isSuccess{
                // saves the data into a json object
                let quoteJson : JSON =  JSON(response.result.value!)
                // Passes quote data to handler function
                self.updateQuoteLabels(json: quoteJson)
            }else{
                print("there was an error")
            }
        }
        
    }
    
    func  updateQuoteLabels(json: JSON){
        // If the data has exists
        if let quote = json["quote"].string{
            quoteModel.quote = quote
            quoteModel.artist = json["artist"].stringValue
            quoteModel.song = json["song"].stringValue
            updateUI()
        }else {
            quoteLabel.text = "There seems to be an error, try again later"
            
        }
    }
    
    func updateUI(){
        quoteLabel.text = quoteModel.quote
        songLabel.text = "\(quoteModel.song), by: \(quoteModel.artist)"
    }
    
}

