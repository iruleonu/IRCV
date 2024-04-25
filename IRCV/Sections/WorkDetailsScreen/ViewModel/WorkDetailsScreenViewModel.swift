//
//  WorkDetailsScreenViewModel.swift
//  IRCV
//
//  Created by Nuno Salvador on 17/06/2019.
//  Copyright © 2019 Nuno Salvador. All rights reserved.
//

import Foundation

import SwiftUI
import Combine

final class WorkDetailsScreenViewModel: ObservableObject {
    private(set) var routing: WorkDetailsRouting
    @Published private(set) var workExperience: WorkExperience

    var didChange = PassthroughSubject<WorkDetailsScreenViewModel, Never>()
    
    init(routing: WorkDetailsRouting, workExperience: WorkExperience) {
        self.routing = routing
        self.workExperience = workExperience
    }
}
