//
//  GlanceController.swift
//  Rumor Mill WatchKit Extension
//
//  Created by Justin Oakes on 11/21/14.
//  Copyright (c) 2014 Justin Oakes. All rights reserved.
//

import WatchKit
import Foundation


class GlanceController: WKInterfaceController {

    @IBOutlet weak var glanceLabel: WKInterfaceLabel!
    let sharedData = NSUserDefaults(suiteName: "com.joakes.shared values")
    
    override init(context: AnyObject?) {
        // Initialize variables here.
        super.init(context: context)
        
        // Configure interface objects here.
        NSLog("%@ init", self)
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        NSLog("%@ will activate", self)
        glanceLabel.setText(sharedData?.valueForKey("title")?.string)
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        NSLog("%@ did deactivate", self)
        super.didDeactivate()
    }

}
