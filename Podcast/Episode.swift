//
//  Episode.swift
//  Podcast
//
//  Created by Zach Auten on 5/11/16.
//  Copyright © 2016 Zach Auten. All rights reserved.
//

import Foundation

class Episode: NSObject {
    var episodeTitle: String?
    var episodeDate: String?
    var episodeDescription: String?
    var episodeUrl: String?

    init(episodeTitle: String, episodeDate: String, episodeDescription: String, episodeUrl: String) {
        self.episodeTitle = episodeTitle
        self.episodeDate = episodeDate
        self.episodeDescription = episodeDescription
        self.episodeUrl = episodeUrl
    }
}