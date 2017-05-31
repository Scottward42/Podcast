//
//  EpisodeList.swift
//  Podcast
//
//  Created by Zach Auten on 5/11/16.
//  Copyright © 2016 Zach Auten. All rights reserved.
//

import UIKit
import AVFoundation

class EpisodeList: UITableViewController, NSXMLParserDelegate {

    
    
    var player: AVPlayer!
    var nowPlaying = -1
    let cellIdentifier = "myCell"
    var episodes = [Episode]()
    var parser = NSXMLParser()

    var entryTitle: String!
    var entryDate: String!
    var entryDescription: String!
    var entryUrl: String!

    var currentParsedElement = String()
    var insideItem = false

    var podcastUrl = NSURL()

    /**
    class Episode: NSObject {
        var episodeTitle = String()
        var episodeDate = String()
        var episodeDuration = String()
        var episodeSubtitle = String()
        var episodeDescription = String()
        var episodeUrl = String()
    }
    **/

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.registerClass(TableCellTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        let nib = UINib(nibName: "TableCellTableViewCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: cellIdentifier)
        parseXML()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! TableCellTableViewCell
        if (episodes.count == 0)
        {
            return cell
        }
        else
        {
            let rowData = episodes[indexPath.row]
            cell.nameLabel.text = rowData.episodeTitle
            return cell
        }
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let episodeUrl = NSURL(string: episodes[indexPath.row].episodeUrl!)

        if indexPath.row != nowPlaying
        {
            nowPlaying = indexPath.row

            let playerItem = AVPlayerItem(URL: episodeUrl!)

            self.player = AVPlayer(playerItem:playerItem)
            player!.volume = 1.0
            player!.play()
        }
        else if player.rate == 0
        {
            player.play()
        }
        else if player.rate != 0
        {
            player.pause()
        }
    }

    func parseXML() {
        self.parser = NSXMLParser(contentsOfURL: podcastUrl)!
        self.parser.delegate = self
        self.parser.parse()
    }

    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {

        if elementName == "item" {
            insideItem = true
        }
        if insideItem
        {
            switch elementName
            {
                case "title":
                    entryTitle = String()
                    currentParsedElement = "title"
                case "description":
                    entryDescription = String()
                    currentParsedElement = "description"
                case "enclosure":
                    if (attributeDict["url"] != nil){
                        entryUrl = attributeDict["url"]!
                    }
                    currentParsedElement = "enclosure"
                case "pubDate":
                    entryDate = String()
                    currentParsedElement = "pubDate"
                default: break
            }
        }
    }

    func parser(parser: NSXMLParser, foundCharacters string: String) {
        if insideItem
        {
            switch currentParsedElement
            {
                case "title":
                    entryTitle = entryTitle + string
                case "description":
                    entryDescription = entryDescription + string
                case "enclosure":
                    entryUrl = entryUrl + string
                case "pubDate":
                    entryDate = entryDate + string
                default: break
            }
        }
    }

    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if insideItem
        {
            switch elementName
            {
                case "title":
                    currentParsedElement = ""
                case "description":
                    currentParsedElement = ""
                case "enclosure":
                    currentParsedElement = ""
                case "pubDate":
                    currentParsedElement = ""
                default: break
            }
            if elementName == "item"
            {
                let entryEpisode = Episode(episodeTitle: entryTitle, episodeDate: entryDate, episodeDescription: entryDescription, episodeUrl: entryUrl)
                /**
                entryEpisode.episodeTitle = entryTitle
                entryEpisode.episodeDescription = entryDescription
                entryEpisode.episodeUrl = entryUrl
                **/

                episodes.append(entryEpisode)
                insideItem = false
            }
        }
    }
}