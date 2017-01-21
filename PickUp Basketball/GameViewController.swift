//
//  GameTableViewController.swift
//  PickUp Basketball
//
//  Created by Daniel Rica on 12/18/16.
//  Copyright © 2016 Viral Labs. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var valueTime:String!
    var startTimes = ["9:00 am", "9:30 am", "10:00 am", "10:30 am", "11:00 am", "11:30 am", "12:00 pm",
                      "12:30 pm", "1:00 pm", "1:30 pm", "2:00 pm", "2:30 pm", "3:00 pm", "3:30 pm", "4:00 pm",
                      "4:30 pm"]
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindToGameTimes(storyboard: UIStoryboardSegue) {
        
    }

    
    func tableView(tableView:UITableView, numberOfRowsInSection section:Int) -> Int
    {
        return self.startTimes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! GameCell
        cell.textLabel?.text = startTimes[indexPath.item]
        
        
        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let currentCell = tableView.cellForRowAtIndexPath(indexPath)! as UITableViewCell as! GameCell
        let indexPath = tableView.indexPathForSelectedRow!
        valueTime = startTimes[indexPath.row]
        currentCell.timeStart = startTimes[indexPath.row]
        
        self.performSegueWithIdentifier("showGameInfo", sender: indexPath);
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        
        if (segue.identifier == "showGameInfo") {
            
            // initialize new view controller and cast it as your view controller
            let viewController = segue.destinationViewController as! GameDetailViewController
            
            // your new view controller should have property that will store passed value
            viewController.time = valueTime
            
        }
    }

}
