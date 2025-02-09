//
//  Repo.swift
//  DesafioAgileTV
//
//  Created by Bruno Rodrigues on 08/02/25.
//

import Foundation

struct Repo: Codable, Identifiable {
    let id: Int?
    let name: String?
    let language: String?
    let owner: Owner
    
    struct Owner: Codable {
        let id: Int?
        let login: String?
        let avatarUrl: String?
        
        enum CodingKeys: String, CodingKey {
            case id
            case login
            case avatarUrl = "avatar_url"
        }
    }
}
