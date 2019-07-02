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

final class ProfileScreenViewModel: BindableObject {
    private(set) var routing: ProfileScreenRouting
    private var apiService: APIFetchCVProtocol
    
    var didChange = PassthroughSubject<ProfileScreenViewModel, Never>()
    
    var name = ""
    var overview = ""
    var techSkills = [TechSkill]()
    var workExperience = [WorkExperience]()
    var profileImageUrl = ""
    
    private(set) var userProfile: User {
        didSet {
            name = userProfile.name
            overview = userProfile.overview
            techSkills = userProfile.techSkills
            workExperience = userProfile.workExperience
            profileImageUrl = userProfile.profileImageUrl
            didChange.send(self)
        }
    }
    
    private var cancellable: Cancellable? {
        didSet { oldValue?.cancel() }
    }
    
    deinit {
        cancellable?.cancel()
    }
    
    init(routing: ProfileScreenRouting, network: APIFetchCVProtocol) {
        self.routing = routing
        self.apiService = network
        self.userProfile = ProfileScreenViewModel.readPersistedUser()
    }
    
    func onAppear() {
        didChange.send(self)
        fetchUserCVFromGithub()
    }
    
    private func fetchUserCVFromGithub() {
        cancellable = apiService.fetchUserProfile()
            .catch({ (error) -> AnyPublisher<User, APIServiceError> in
                return AnyPublisher { subscriber in
                    let userProfile: User = ProfileScreenViewModel.readPersistedUser()
                    _ = subscriber.receive(userProfile)
                }
            })
            .sink { [weak self] (userProfile) in
                guard let self = self else { return }
                self.userProfile = userProfile
        }
    }
    
    private static func readPersistedUser() -> User {
        let userProfile: User = ReadFile.object(from: "nscv", extension: "json")
        return userProfile
    }
}
