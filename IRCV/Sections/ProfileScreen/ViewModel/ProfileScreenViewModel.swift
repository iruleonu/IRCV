//
//  ProfileScreenViewModel.swift
//  IRCV
//
//  Created by Nuno Salvador on 17/06/2019.
//  Copyright © 2019 Nuno Salvador. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

@MainActor
final class ProfileScreenViewModel: ObservableObject {
    private(set) var routing: ProfileScreenRouting
    private var apiService: APIFetchCVProtocol

    @Published var name = ""
    @Published var overview = ""
    @Published var techSkills = [TechSkill]()
    @Published var workExperience = [WorkExperience]()
    @Published var profileImageUrl = ""

    private(set) var userProfile: User {
        didSet {
            name = userProfile.name
            overview = userProfile.overview
            techSkills = userProfile.techSkills
            workExperience = userProfile.workExperience
            profileImageUrl = userProfile.profileImageUrl
        }
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    init(routing: ProfileScreenRouting, network: APIFetchCVProtocol) {
        self.routing = routing
        self.apiService = network
        self.userProfile = ProfileScreenViewModel.readPersistedUser()
    }
    
    func onAppear() async {
        await fetchUserCVFromGithubAsync()
    }
}

private extension ProfileScreenViewModel {
    func fetchUserCVFromGithubAsync() async {
        do {
            let fetchUserProfile = try await apiService.fetchUserProfileAsync()
            self.userProfile = fetchUserProfile
        } catch {
            let userProfile: User = ProfileScreenViewModel.readPersistedUser()
            self.userProfile = userProfile
        }
    }

    static func readPersistedUser() -> User {
        let userProfile: User = ReadFile.object(from: "nscv", extension: "json")
        return userProfile
    }
}
