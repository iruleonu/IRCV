//
//  ProfileScreenCoordinator.swift
//  IRCV
//
//  Created by Nuno Salvador on 17/06/2019.
//  Copyright © 2019 Nuno Salvador. All rights reserved.
//

import Foundation
import UIKit

protocol ProfileScreenRouting {
    func buildDetailedWorkExperience(workExperience: WorkExperience) -> WorkDetailsScreen
    func buildDetailedWorkExperience(workExperience: WorkExperience, action: @escaping (ProfileScreenAction) -> Void) -> WorkDetailsScreen
}

final class ProfileScreenCoordinator: ProfileScreenRouting {
    private let builders: ProfileScreenChildBuilders
    private let network: APIFetchCVProtocol
    
    init(builders b: ProfileScreenChildBuilders, network n: APIFetchCVProtocol) {
        builders = b
        network = n
    }
    
    func buildDetailedWorkExperience(workExperience: WorkExperience) -> WorkDetailsScreen {
        return builders.makeDetailedWorkExperience(workExperience: workExperience)
    }
    
    func buildDetailedWorkExperience(workExperience: WorkExperience, action: @escaping (ProfileScreenAction) -> Void) -> WorkDetailsScreen {
        return builders.makeDetailedWorkExperience(workExperience: workExperience)
    }
}
