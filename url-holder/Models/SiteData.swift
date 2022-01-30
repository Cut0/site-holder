//
//  SiteData.swift
//  url-holder
//
//  Created by Rei Kato on 2022/01/30.
//

import Foundation

struct SiteData: Identifiable, Codable {
    var id = UUID()
    var title: String
    var type: String
    var description: String
    var imageURL: String
    var url: String
}
