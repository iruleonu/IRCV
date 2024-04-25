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
    
    func onAppear() {
        fetchUserCVFromGithub()
    }
    
    private func fetchUserCVFromGithub() {
        apiService.fetchUserProfile()
            .catch({ (error) -> Future<User, Never> in
                Future { promise in
                    let userProfile: User = ProfileScreenViewModel.readPersistedUser()
                    promise(.success(userProfile))
                }
            })
            .receive(on: DispatchQueue.main)
            .sink { [weak self] (userProfile) in
                guard let self = self else { return }
                self.userProfile = userProfile
            }
            .store(in: &cancellables)
    }
    
    private static func readPersistedUser() -> User {
        let userProfile: User = ReadFile.object(from: "nscv", extension: "json")
        return userProfile
    }
}
