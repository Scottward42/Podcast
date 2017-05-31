//
//  SearchView.swift
//  Podcast
//
//  Created by Zachary Auten on 4/18/16.
//  Copyright © 2016 Zach Auten. All rights reserved.
//

import UIKit

class SearchView: UIViewController, UISearchBarDelegate, UITableViewDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    var podcasts = [Podcast]()
    let cellIdentifier = "myCell"
    var searchController = UISearchController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerClass(TableCellTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        let nib = UINib(nibName: "TableCellTableViewCell", bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: cellIdentifier)
        
        let searchBar = searchController.searchBar
        searchBar.sizeToFit()
        tableView.tableHeaderView = searchBar
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return podcasts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! TableCellTableViewCell
        if (podcasts.count == 0)
        {
            return cell
        }
        else
        {
            let rowData = podcasts[indexPath.row]
            cell.nameLabel.text = rowData.collectionName
            return cell
        }
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        self.performSegueWithIdentifier("epseg", sender: self)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if(segue.identifier == "epseg")
        {
            let targetVC = segue.destinationViewController as! EpisodeList;
            targetVC.podcastUrl = podcasts[(self.tableView.indexPathForSelectedRow?.row)!].feedUrl!
        }
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        let searchString = searchBar.text!
        podcasts = Podcast.downloadPodcasts(searchString)
        self.searchBar.resignFirstResponder()
        self.tableView.reloadData()
    }
}
