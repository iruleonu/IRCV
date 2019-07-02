//
//  WorkDetailsScreenBuilder.swift
//  IRCV
//
//  Created by Nuno Salvador on 17/06/2019.
//  Copyright © 2019 Nuno Salvador. All rights reserved.
//

import SwiftUI

// Actions available from childs built from PostsListChildBuilders
enum WorkDetailsScreenAction {
    // Empty
}

protocol WorkDetailsScreenChildBuilders {
    // Empty
}

struct WorkDetailsScreenBuilder {
    func make(workExperience: WorkExperience) -> WorkDetailsScreen {
        let coordinator = WorkDetailsCoordinator(builders: self)
        let vm = WorkDetailsScreenViewModel(routing: coordinator, workExperience: workExperience)
        return WorkDetailsScreen(viewModel: vm)
    }
}

extension WorkDetailsScreenBuilder: WorkDetailsScreenChildBuilders {
    
}
