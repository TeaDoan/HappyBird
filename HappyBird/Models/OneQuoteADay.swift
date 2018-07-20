//
//  OneQuoteADay.swift
//  HappyBird
//
//  Created by Thao Doan on 7/12/18.
//  Copyright © 2018 Thao Doan. All rights reserved.
//

import Foundation
public struct OneQuoteADay : Codable{
    public var quote : String
    public var author : String
    public var title : String
    public var date : String?
    public var background:String?
}
public struct Contents: Codable {
    public let quotes : [OneQuoteADay]
}
public struct ToplevelData: Codable {
    public let contents : Contents
}

