//
//  RMTableTableViewController.swift
//  Rumor Mill
//
//  Created by Justin Oakes on 11/19/14.
//  Copyright (c) 2014 Justin Oakes. All rights reserved.
//

import UIKit

class RMTableTableViewController: UITableViewController, NSXMLParserDelegate {
    
    var parser: NSXMLParser = NSXMLParser()
    var blogPosts: [BlogPost] = []
    
    var postTitle: String = String()
    var postDescription: String = String()
    var ename: String = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url: NSURL = NSURL(string: "http://feeds.macrumors.com/MacRumors-All?format=xml")!
        parser = NSXMLParser(contentsOfURL: url)!
        parser.delegate = self
        parser.parse()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return blogPosts.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        // Configure the cell...
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        let blogPost: BlogPost = blogPosts[indexPath.row]
        
        let row = 0
        
        cell.textLabel.text = blogPost.postTitle
        cell.textLabel.numberOfLines = 0
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "viewPost" {
            var index = tableView.indexPathForSelectedRow()?.row
            
            let blogPost: BlogPost = blogPosts[index!]
            
            let viewController = segue.destinationViewController as ArticleViewController
            
            viewController.text = blogPost.postDescription
        }
    }
    
    
    func parser(parser: NSXMLParser!, didStartElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!, attributes attributeDict: [NSObject : AnyObject]!) {
        ename = elementName
        if elementName == "item" {
            postTitle = String()
            postDescription = String()
        }
    }


    func parser(parser: NSXMLParser!, foundCharacters string: String!) {
        let data = string.stringByTrimmingCharactersInSet((NSCharacterSet.whitespaceAndNewlineCharacterSet()))
        
        if (!data.isEmpty){
            if ename == "title" {
                postTitle += data
            } else if ename == "description" {
                postDescription += data
            }
        }
    }
    
    func parser(parser: NSXMLParser!, didEndElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!) {
        if elementName == "item" {
            let blogPost: BlogPost = BlogPost()
            blogPost.postTitle = postTitle
            blogPost.postDescription = postDescription
            
            blogPosts.append(blogPost)
        }
    }
}
