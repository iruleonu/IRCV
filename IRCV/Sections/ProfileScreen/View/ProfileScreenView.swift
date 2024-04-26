//
//  ProfileScreenView.swift
//  IRCV
//
//  Created by Nuno Salvador on 17/06/2019.
//  Copyright © 2019 Nuno Salvador. All rights reserved.
//

import SwiftUI

struct ProfileScreenView : View {
    @ObservedObject private var viewModel: ProfileScreenViewModel

    init(viewModel: ProfileScreenViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationView {
            List {
                ProfileOverview(
                    name: $viewModel.name,
                    overview: $viewModel.overview,
                    techSkills: $viewModel.techSkills,
                    profileImageUrl: $viewModel.profileImageUrl
                )

                ForEach(viewModel.workExperience) { workExperience in
                    NavigationLink {
                        self.viewModel.routing.buildDetailedWorkExperience(workExperience: workExperience)
                    } label: {
                        ProfileScreenWorkExperienceCell(workExperience: workExperience)
                    }
                }
                .listRowInsets(EdgeInsets(top: 5, leading: 30, bottom: 5, trailing: 30))

            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
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
            HStack(alignment: .center) {
                AsyncImage(url: URL(string: profileImageUrl)) { phase in
                    switch phase {
                    case .failure:
                        Image("placeholder")
                    case .success(let image):
                        image.resizable()
                    default:
                        ProgressView()
                    }
                }
                .frame(width: 124, height: 124)
                .clipShape(.rect(cornerRadius: 124))
            }
            .padding(.top, 15)
            .frame(maxWidth: .infinity)

            Text(name)
                .font(.headline)
                .padding([.leading, .trailing], 15)
                .frame(maxWidth: .infinity)

            Text("Overview")
                .font(.headline)
                .padding([.leading, .trailing], 15)
                .padding(.top, 15)

            Text(overview)
                .font(.subheadline)
                .lineLimit(20)
                .padding([.leading, .trailing], 15)
                .padding(.top, 5)

            Text("Skills (horizontal list)")
                .font(.headline)
                .padding([.leading, .trailing], 15)
                .padding(.top, 15)

            ProfileScreenTechSkillsRow(items: techSkills)
                .padding([.leading, .trailing], 15)
                .frame(height: 15)

            Text("Work experience")
                .font(.largeTitle)
                .padding([.leading, .trailing], 15)
                .padding(.top, 25)
                .frame(maxWidth: .infinity)
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

