//
//  ProfileScreenBuilder.swift
//  IRCV
//
//  Created by Nuno Salvador on 17/06/2019.
//  Copyright © 2019 Nuno Salvador. All rights reserved.
//

import SwiftUI

// Actions available from childs built from PostsListChildBuilders
enum ProfileScreenAction {
    // Empty
}

protocol ProfileScreenChildBuilders {
    func makeDetailedWorkExperience(workExperience: WorkExperience) -> WorkDetailsScreen
}

struct ProfileScreenBuilder {
    func make(network: APIFetchCVProtocol) -> ProfileScreenView {
        let coordinator = ProfileScreenCoordinator(builders: self, network: network)
        let vm = ProfileScreenViewModel(routing: coordinator, network: network)
        return ProfileScreenView(viewModel: vm)
    }
}

extension ProfileScreenBuilder: ProfileScreenChildBuilders {
    func makeDetailedWorkExperience(workExperience: WorkExperience) -> WorkDetailsScreen {
        return WorkDetailsScreenBuilder().make(workExperience: workExperience)
    }
}
