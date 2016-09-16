//
//  ItemsTableViewController.swift
//  NewsAppParsing
//
//  Created by Admin on 15.09.16.
//  Copyright © 2016 Bobrovnikov. All rights reserved.
//

import UIKit



let ContentItemVCShowSegueIdentifier = "ShowContentItem"

class ItemsTableViewController: UITableViewController {
    
    

    let NewsLoadURL = "https://newsapi.org/v1/articles?source=bbc-news&sortBy=popular&apiKey=017075ac513641ad938be721cee69173"
    
    
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
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ArrayArticles.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! ItemsTableViewCell
        
        // Configure the cell...
        
        
        let content = ArrayArticles[indexPath.row]
        cell.TitleLabel.text = content.title
        cell.DescriptionLabel.text = content.description
        cell.PublishedAtLabel.text = content.publishedAt
        cell.UrlToImageLabel.image = content.image

        
        
        return cell
    }
    
    
    
    
    // MARK: - UITableViewDelegate
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier(ContentItemVCShowSegueIdentifier as String, sender: tableView)
        
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
    
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == ContentItemVCShowSegueIdentifier {
            if let vc = segue.destinationViewController as? ContentItemViewController, indexPath = self.tableView.indexPathForSelectedRow {
                
                let content = ArrayArticles[indexPath.row]
                
                vc.title = content.title
                vc.urlString = content.url
            }
        }
    }

    
    

    
    func getLatestArticles() {
        
        
        let request = NSURLRequest(URL: NSURL(string: NewsLoadURL)!)
        let urlSession = NSURLSession.sharedSession()
        let task = urlSession.dataTaskWithRequest(request, completionHandler:  { (data, response, error) -> Void in
            
            if let error = error {
                print(error)
                return
            }
            
            
            
           
            //Parsing
            
        
            if let data = data {

              self.ArrayArticles = self.parseJsonData(data)
                
                            
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    self.tableView.reloadData()
                })
            }
            
        })
        task.resume()
    }
    
    func parseJsonData(data: NSData) -> [Articles] {
        do {
            let jsonResult = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
            
            //Parse JSON Data
            let jsonArticles = jsonResult?["articles"] as! [AnyObject]
            for jsonArticle in jsonArticles {
                var article = Articles()
                article.author = jsonArticle["author"] as! String
                article.title = jsonArticle["title"] as! String
                article.description = jsonArticle["description"] as! String
                 article.url = jsonArticle["url"] as! String
                 article.urlToImage = jsonArticle["urlToImage"] as! String
                 article.publishedAt = jsonArticle["publishedAt"] as! String
                
                                
                ArrayArticles.append(article)
                
                
            
            }
            
        } catch {
            print(error)
        }
        
        return ArrayArticles
    }
    
    
}

    
    

