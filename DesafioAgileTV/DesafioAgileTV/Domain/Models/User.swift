//
//  User.swift
//  DesafioAgileTV
//
//  Created by Bruno Rodrigues on 08/02/25.
//

import Foundation

struct User: Codable {
    let id: Int?
    let login: String?
    let avatarUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case login
        case avatarUrl = "avatar_url"
    }
}
