//
//  WorkExperience.swift
//  IRCV
//
//  Created by Nuno Salvador on 17/06/2019.
//  Copyright © 2019 Nuno Salvador. All rights reserved.
//

import Foundation
import SwiftUI

struct WorkExperience: Hashable, Codable, Identifiable {
    let id: Int
    let companyName: String
    let companyLocation: String
    let role: String
    let startDate: String
    let endDate: String
    let jobDescription: String
    
    private enum Constants: Int {
        case defaultId = -1
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case companyName
        case companyLocation
        case role
        case startDate
        case endDate
        case jobDescription
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let id = try container.decode(Int.self, forKey: .id)
        let companyName = try container.decode(String.self, forKey: .companyName)
        let companyLocation = try container.decode(String.self, forKey: .companyLocation)
        let role = try container.decode(String.self, forKey: .role)
        let startDate = try container.decode(String.self, forKey: .startDate)
        let endDate = try container.decode(String.self, forKey: .endDate)
        let jobDescription = try container.decode(String.self, forKey: .jobDescription)
        self.init(id: id,
                  companyName: companyName,
                  companyLocation: companyLocation,
                  role: role,
                  startDate: startDate,
                  endDate: endDate,
                  jobDescription: jobDescription)
    }
    
    init(id: Int = Constants.defaultId.rawValue, companyName: String = "", companyLocation: String = "", role: String = "", startDate: String = "", endDate: String = "", jobDescription: String = "") {
        self.id = id
        self.companyName = companyName
        self.companyLocation = companyLocation
        self.role = role
        self.startDate = startDate
        self.endDate = endDate
        self.jobDescription = jobDescription
    }
}

extension WorkExperience: Equatable {
    static func == (left: WorkExperience, right: WorkExperience) -> Bool {
        return left.id == right.id
    }
}
