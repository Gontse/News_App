//
//  News.swift
//  NewsApp
//
//  Created by Gontse Ranoto on 2019/08/05.
//  Copyright © 2019 Gontse Ranoto. All rights reserved.
//

import Foundation


struct News: Codable  {
    
    let Headline: String
    let Blurb : String
    let SiteName : String
    let UrlName: String
    let UrlFriendlyDate: String
    let UrlFriendlyHeadline: String
    let SmallImageName: String
    let DateCreated: String
    let LargeImageName: String
}
