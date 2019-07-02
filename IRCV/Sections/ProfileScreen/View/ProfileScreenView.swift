//
//  ProfileScreenView.swift
//  IRCV
//
//  Created by Nuno Salvador on 17/06/2019.
//  Copyright © 2019 Nuno Salvador. All rights reserved.
//

import SwiftUI

struct ProfileScreenView : View {
    @ObjectBinding var viewModel: ProfileScreenViewModel
    
    var body: some View {
        NavigationView {
            List {
                ProfileOverview(name: viewModel[\.name],
                                overview: viewModel[\.overview],
                                techSkills: viewModel[\.techSkills],
                                profileImageUrl: viewModel[\.profileImageUrl])
                    .frame(height: 500)
                ForEach(viewModel.workExperience) { workExperience in
                    NavigationButton(destination: self.viewModel.routing.buildDetailedWorkExperience(workExperience: workExperience)) {
                        ProfileScreenWorkExperienceCell(workExperience: workExperience)
                    }
                    }
                    .listRowInsets(EdgeInsets(top: 5, leading: 30, bottom: 5, trailing: 30))
                }
                .onAppear { self.viewModel.onAppear() }
                .navigationBarTitle(Text("CV"))
        }
    }
}

struct ProfileOverview: View {
    @Binding var name: String
    @Binding var overview: String
    @Binding var techSkills: [TechSkill]
    @Binding var profileImageUrl: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(name)
                .font(.headline)
                .padding(.leading, 15)
                .padding(.top, 5)
            Text(overview)
                .font(.subheadline)
                .lineLimit(20)
                .padding(.leading, 15)
                .padding(.top, 5)
            Text("Skills (horizontal list)")
                .font(.headline)
                .padding(.leading, 15)
                .padding(.top, 5)
            ProfileScreenTechSkillsRow(items: techSkills)
                .padding([.leading, .trailing], 15)
                .frame(height: 35)
            Text("Work experience")
                .font(.headline)
        }
    }
}

#if DEBUG
struct ProfileScreenView_Previews : PreviewProvider {
    static var previews: some View {
        return ProfileScreenBuilder().make(network: APIServiceImpl.default)
    }
}
#endif

