//
//  User.swift
//  IRShowcase
//
//  Created by Nuno Salvador on 23/03/2019.
//  Copyright © 2019 Nuno Salvador. All rights reserved.
//

import Foundation

struct User: Codable {
    let id: Int
    let name: String
    let username: String
    let profileImageUrl: String
    let overview: String
    let techSkills: [TechSkill]
    let workExperience: [WorkExperience]

    private enum Constants: Int {
        case defaultId = -1
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case username
        case profileImageUrl
        case overview
        case techSkills
        case workExperience
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let id = try container.decode(Int.self, forKey: .id)
        let name = try container.decode(String.self, forKey: .name)
        let username = try container.decode(String.self, forKey: .username)
        let profileImageUrl = try container.decode(String.self, forKey: .profileImageUrl)
        let overview = try container.decode(String.self, forKey: .overview)
        let techSkills = try container.decode([TechSkill].self, forKey: .techSkills)
        let workExperience = try container.decode([WorkExperience].self, forKey: .workExperience)
        self.init(id: id, name: name, username: username, profileImageUrl: profileImageUrl, overview: overview, techSkills: techSkills, workExperience: workExperience)
    }
    
    init(id: Int = Constants.defaultId.rawValue, name: String = "", username: String = "", profileImageUrl: String = "", overview: String = "", techSkills: [TechSkill] = [], workExperience: [WorkExperience] = []) {
        self.id = id
        self.name = name
        self.username = username
        self.profileImageUrl = profileImageUrl
        self.overview = overview
        self.techSkills = techSkills
        self.workExperience = workExperience
    }
}

extension User: Equatable {
    static func == (left: User, right: User) -> Bool {
        return left.id == right.id
    }
}
