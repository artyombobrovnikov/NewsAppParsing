//
//  ItemsTableViewController.swift
//  NewsAppParsing
//
//  Created by Admin on 15.09.16.
//  Copyright © 2016 Bobrovnikov. All rights reserved.
//

import UIKit



let ContentItemVCShowSegueIdentifier = "ShowContentItem"
typealias JSONArray = [AnyObject]
typealias JSONDictionary = [String: AnyObject]



class ItemsTableViewController: UITableViewController {
    
    

    let NewsLoadURL = "https://newsapi.org/v1/articles?source=national-geographic&sortBy=top&apiKey=017075ac513641ad938be721cee69173"
    
    
    var ArrayArticles = [Articles]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getLatestArticles()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ArrayArticles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ItemsTableViewCell
        
        // Configure the cell...
        
        
       
        cell.TitleLabel.text = ArrayArticles[indexPath.row].title
        cell.DescriptionLabel.text = ArrayArticles[indexPath.row].description
        cell.PublishedAtLabel.text = ArrayArticles[indexPath.row].publishedAt
        cell.updateWithImage((indexPath as NSIndexPath).row)

        
        
        return cell
    }
    
    
    
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: ContentItemVCShowSegueIdentifier as String, sender: tableView)
        
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == ContentItemVCShowSegueIdentifier {
            if let vc = segue.destination as? ContentItemViewController, let indexPath = self.tableView.indexPathForSelectedRow {
                
                let content = ArrayArticles[(indexPath as NSIndexPath).row]
                
                vc.title = content.title
                vc.urlString = content.url
            }
        }
    }

    
    

    
    func getLatestArticles() {
        
        
        let request = URLRequest(url: URL(string: NewsLoadURL)!)
        let urlSession = URLSession.shared
        let task = urlSession.dataTask(with: request, completionHandler:  { (data, response, error) -> Void in
            
            if let error = error {
                print(error)
                return
            }
            
            
       //Parsing
            
        
            if let data = data {

              self.ArrayArticles = self.parseJsonData(data: data)
                
                
                                            
                OperationQueue.main.addOperation({ () -> Void in
                    self.tableView.reloadData()
                })
            }
            
        })
        task.resume()
    }
 
    
    func parseJsonData( data: Data) -> [Articles] {
        do {
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
            
            //Parse JSON Data
            let jsonArticles = jsonResult?["articles"] as! [AnyObject]
            for jsonArticle in jsonArticles {
                var article = Articles()
                article.author = jsonArticle["author"] as! String
                article.title = jsonArticle["title"] as! String
                article.description = jsonArticle["description"] as! String
                 article.url = jsonArticle["url"] as! String
              //   article.urlToImage = jsonArticle["urlToImage"] as! String
                 article.publishedAt = jsonArticle["publishedAt"] as! String
                
                
                ArrayArticles.append(article)
                
                
            
            }
            
        } catch {
            print(error)
        }
        
        return ArrayArticles
    }
    
    
}
    
