//
//  ArticleViewController.swift
//  Rumor Mill
//
//  Created by Justin Oakes on 11/20/14.
//  Copyright (c) 2014 Justin Oakes. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController {

    
    
    @IBOutlet weak var articleText: UIWebView!
   
    
        
    var text: String = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //articleText.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions(), context: nil)
        articleText.loadHTMLString(text, baseURL: nil)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidDisappear(animated: Bool) {
        //articleText.removeObserver(self, forKeyPath: "contentSize")
    }
    
    override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
        let tv: UITextView = object as UITextView
        
        var topCorrect: CGFloat = (tv.bounds.size.height - tv.contentSize.height * tv.zoomScale) / 2.0
        topCorrect = topCorrect < 0.0 ? 0.0 : topCorrect
        tv.contentOffset = CGPoint(x: 0, y: -topCorrect)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
