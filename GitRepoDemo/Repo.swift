//
//  Repo.swift
//  GitRepoDemo
//
//  Created by Manikanta Nallabelly on 5/3/18.
//  Copyright © 2018 Akvelon. All rights reserved.
//

import Foundation

struct License:Encodable, Decodable {
    let key:String
    let name:String
}

struct Repo : Encodable, Decodable {
    let name:String
    let description:String?
    let created_at:String
    let license:License?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case description = "description"
        case created_at = "created_at"
        case license = "license"
    }
}

