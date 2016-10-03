//
//  SourceTableViewController.swift
//  NewsAppParsing
//
//  Created by Admin on 19.09.16.
//  Copyright © 2016 Bobrovnikov. All rights reserved.
//


import Foundation
import UIKit

 
class SourceTableViewController: UITableViewController {
    
    let SourceURL = "https://newsapi.org/v1/sources?language=en"
     var ArraySource = [Sources]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getLatestSources()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
// MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return ArraySource.count
        }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SourceTableViewCell
         
        // Configure the cell...
          // cell.LogosLabel.image = ArraySource[indexPath.row].image
            
            

            cell.NameLabel.text = ArraySource[indexPath.row].name
            cell.DescriptionLabel.text = ArraySource[indexPath.row].description
            cell.CountryLabel.text = ArraySource[indexPath.row].country
            cell.CategoryLabel.text = ArraySource[indexPath.row].category
            cell.updateWithImage((indexPath as NSIndexPath).row)
            return cell
    }
    
    
          override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                if (indexPath as NSIndexPath).row == 0 {
                    self.performSegue(withIdentifier: "segue0", sender: self)
                } else if (indexPath as NSIndexPath).row == 1 {
                    self.performSegue(withIdentifier: "segue1", sender: self)
                } else {
           }
    }
    
            func getLatestSources() {
            let request = URLRequest(url: URL(string: SourceURL)!)
            let urlSession = URLSession.shared
            let task = urlSession.dataTask(with: request, completionHandler:  { (data, response, error) -> Void in
                if let error = error {
                    print(error)
                    return
                }
                
//Parsing
                if let data = data {
                    self.ArraySource = self.parseJsonData(data: data)
                    OperationQueue.main.addOperation({ () -> Void in
                        self.tableView.reloadData()
                    })
                }
            })
            task.resume()
        }
    
        func parseJsonData( data: Data) -> [Sources] {
            do {
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
                
//Parse JSON Data
                let jsonSources = jsonResult?["sources"] as! [AnyObject]
                for jsonSource in jsonSources {
                    let source = Sources()
                    source.id = jsonSource["id"] as! String
                    source.name = jsonSource["name"] as! String
                    source.description = jsonSource["description"] as! String
                    source.country = jsonSource["country"] as! String
                    source.category = jsonSource["category"] as! String
                    
                    ArraySource.append(source)
                    
                }
                
            } catch {
                print(error)
            }
            
            return ArraySource 
        }
        
        
}
