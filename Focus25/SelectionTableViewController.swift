//
//  SelectionTableViewController.swift
//  Focus25
//
//  Created by Agustiadi on 28/2/15.
//  Copyright (c) 2015 Agustiadi. All rights reserved.
//

import UIKit

class SelectionTableViewController: UITableViewController {
    
    
    let image = ["raining.png", "sunset.png", "mountain_lake.png", "snowing.png", "stars_and_moon.png"]
    
    let imageBanner = ["rain", "sun", "lake", "snow", "stars"]
    
    let imageName = ["Pouring Rain", "Tropical Sunset", "Mountain Lake", "Magical Snows", "Beautiful Night Sky"]
    

    override func viewDidLoad() {
        super.viewDidLoad()

            }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 5
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 150
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        

        let cellImage = UIImageView(frame: CGRectMake(0, 0, cell.frame.width, cell.frame.height))
        cellImage.image = UIImage(named: "\(imageBanner[indexPath.row]).png")
        cellImage.clipsToBounds = true
        cellImage.contentMode = UIViewContentMode.ScaleAspectFill
        
        let cellLabel = UILabel(frame: CGRectMake(0, cell.frame.height-30, cell.frame.width, 30 ))
        cellLabel.backgroundColor = UIColor.blackColor()
        cellLabel.alpha = 0.6
        cellLabel.text = "  \(imageName[indexPath.row])"
        cellLabel.textColor = UIColor.whiteColor()
        
        cell.addSubview(cellImage)
        cell.addSubview(cellLabel)

        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "details") {
            
            let vc: DetailsViewController = segue.destinationViewController as DetailsViewController
            let indexPath = self.tableView.indexPathForSelectedRow()
            vc.imageSelected = image[indexPath!.row]
            vc.imageNameSelected = imageName[indexPath!.row]
            vc.soundSelected = imageBanner[indexPath!.row]
            
            
        }
    }
    

}
