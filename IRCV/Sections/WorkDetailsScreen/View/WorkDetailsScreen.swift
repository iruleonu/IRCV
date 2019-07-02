//
//  WorkDetailsScreen.swift
//  IRCV
//
//  Created by Nuno Salvador on 17/06/2019.
//  Copyright © 2019 Nuno Salvador. All rights reserved.
//

import SwiftUI

struct WorkDetailsScreen : View {
    @ObjectBinding var viewModel: WorkDetailsScreenViewModel
    
    var body: some View {
        let vm = viewModel
        return GeometryReader { container in
            ScrollView() {
                ScrollViewContentView(workExperience: vm.workExperience)
                    .frame(idealWidth: container.size.width, minHeight: 1500, alignment: .top)
            }
        }
    }
}

struct ScrollViewContentView : View {
    var workExperience: WorkExperience
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(workExperience.companyName)
                .color(.primary)
                .lineLimit(2)
                .font(.largeTitle)
            
            HStack(alignment: .top, spacing: 2) {
                Text(workExperience.startDate)
                    .color(.primary)
                    .font(.caption)
                Text("-")
                    .color(.primary)
                    .font(.caption)
                Text(workExperience.endDate)
                    .color(.primary)
                    .font(.caption)
            }
            
            Text(workExperience.companyLocation)
                .color(.primary)
                .font(.caption)
            
            Text(workExperience.role)
                .color(.primary)
                .font(.subheadline)
            
            Text(workExperience.jobDescription)
                .color(.primary)
                .font(.footnote)
                .lineLimit(nil)
            }
            .padding()
    }
}

#if DEBUG
struct WorkDetailsScreen_Previews : PreviewProvider {
    static var previews: some View {
        let workXP = WorkExperience(id: 0,
                                    companyName: "Company name",
                                    companyLocation: "Location",
                                    role: "Role",
                                    startDate: "Start date",
                                    endDate: "End date",
                                    jobDescription: "Job description Job description v Job description v v Job description v Job description")
        return WorkDetailsScreenBuilder().make(workExperience: workXP)
    }
}
#endif

