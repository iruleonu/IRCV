//
//  WorkDetailsScreen.swift
//  IRCV
//
//  Created by Nuno Salvador on 17/06/2019.
//  Copyright © 2019 Nuno Salvador. All rights reserved.
//

import SwiftUI
import Combine

struct WorkDetailsScreen : View {
    @ObservedObject var viewModel: WorkDetailsScreenViewModel
    
    var body: some View {
        let vm = viewModel
        return GeometryReader { container in
            ScrollView() {
                ScrollViewContentView(workExperience: vm.workExperience)
            }
        }
    }
}

struct ScrollViewContentView : View {
    var workExperience: WorkExperience
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(workExperience.companyName)
                .foregroundColor(.primary)
                .lineLimit(2)
                .font(.largeTitle)
            
            HStack(alignment: .top, spacing: 2) {
                Text(workExperience.startDate)
                    .foregroundColor(.primary)
                    .font(.caption)
                Text("-")
                    .foregroundColor(.primary)
                    .font(.caption)
                Text(workExperience.endDate)
                    .foregroundColor(.primary)
                    .font(.caption)
            }
            
            Text(workExperience.companyLocation)
                .foregroundColor(.primary)
                .font(.caption)
            
            Text(workExperience.role)
                .foregroundColor(.primary)
                .font(.subheadline)
            
            Text(workExperience.jobDescription)
                .foregroundColor(.primary)
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

