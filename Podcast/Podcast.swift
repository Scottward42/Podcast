//
//  Podcasts.swift
//  Podcast
//
//  Created by Zach Auten on 5/7/16.
//  Copyright © 2016 Zach Auten. All rights reserved.
//

import Foundation

class Podcast
{
    var artistName: String?
    var collectionName: String?
    var feedUrl: NSURL?
    var trackCount: Int?
    var primaryGenreName: String?
    var artworkUrl60: NSURL?

    init (artistName: String, collectionName: String, feedUrl: NSURL, trackCount: Int, primaryGenreName: String, artworkUrl60: NSURL)
    {
        self.artistName = artistName
        self.collectionName = collectionName
        self.feedUrl = feedUrl
        self.trackCount = trackCount
        self.primaryGenreName = primaryGenreName
        self.artworkUrl60 = artworkUrl60
    }

    init (podcastDictionary: [String : AnyObject])
    {
        self.artistName = podcastDictionary["artistName"] as? String
        self.collectionName = podcastDictionary["collectionName"] as? String
        self.feedUrl = NSURL(string: podcastDictionary["feedUrl"] as! String)
        self.trackCount = podcastDictionary["trackCount"] as? Int
        self.primaryGenreName = podcastDictionary["primaryGenreName"] as? String
        self.artworkUrl60 = NSURL(string: podcastDictionary["artworkUrl60"] as! String)
    }

    static func downloadPodcasts(searchString: String) -> [Podcast]
    {
        var podcasts = [Podcast]()
        let jsonData = convertStringToData(searchString)
        if let jsonDic = parseJSON(jsonData)
        {
            let podcastDictionaries = jsonDic["results"] as! [[String : AnyObject]]
            for podcastDictionary in podcastDictionaries
            {
                let newPodcast = Podcast(podcastDictionary : podcastDictionary)
                podcasts.append(newPodcast)
            }
        }
        return podcasts
    }

    static func convertStringToData(searchString: String) -> NSData?
    {
        //replace the search string's spaces with '+' so it can be used as a url.
        let searchUrl = searchString.stringByReplacingOccurrencesOfString(" ", withString: "+").stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        //download json data from url and return it
        return NSData(contentsOfURL: NSURL(string: "https://itunes.apple.com/search?term=" + searchUrl + "&media=podcast")!)
    }

    static func parseJSON(jsonData: NSData?) -> [String : AnyObject]?
    {
        if let data = jsonData
        {
            do
            {
                let jsonDictionary = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as? [String : AnyObject]
                return jsonDictionary
            }
            catch let error as NSError {
                print("error processing json data: \(error.localizedDescription)")
            }
        }
        return nil
    }
}