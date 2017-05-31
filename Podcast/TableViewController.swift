//
//  TableViewController.swift
//  Podcast
//
//  Created by Zachary Auten on 2/16/16.
//  Copyright © 2016 Zach Auten. All rights reserved.
//

import UIKit
//import AVFoundation

class TableViewController: UITableViewController {
    
    let test = ["one", "two", "three", "four"]
    var episodes = [Episode]()
    let cellIdentifier = "myCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.registerClass(TableCellTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        let nib = UINib(nibName: "TableCellTableViewCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: cellIdentifier)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }


    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return test.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! TableCellTableViewCell
        let rowData = test[indexPath.row]

        cell.nameLabel.text = rowData
    
        return cell
    }

    static func addEpisode(episode: Episode)
    {

    }
}
