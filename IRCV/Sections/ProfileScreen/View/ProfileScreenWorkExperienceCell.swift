//
//  ProfileScreenWorkExperienceCell.swift
//  IRCV
//
//  Created by Nuno Salvador on 17/06/2019.
//  Copyright © 2019 Nuno Salvador. All rights reserved.
//

import Foundation

import SwiftUI

struct ProfileScreenWorkExperienceCell: View {
    var workExperience: WorkExperience
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(workExperience.companyName)
                .color(.primary)
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
                Text("|")
                    .color(.primary)
                    .font(.caption)
                Text(workExperience.companyLocation)
                    .color(.primary)
                    .font(.caption)
            }
            
            Text(workExperience.role)
                .color(.primary)
                .font(.subheadline)
            
            Text(workExperience.jobDescription)
                .color(.primary)
                .font(.footnote)
                .lineLimit(2)
        }
    }
}

#if DEBUG
struct ProfileScreenWorkExperienceCell_Previews: PreviewProvider {
    static var previews: some View {
        let workXP = WorkExperience(id: 0,
                                    companyName: "Company name",
                                    companyLocation: "Location",
                                    role: "Role",
                                    startDate: "Start date",
                                    endDate: "End date",
                                    jobDescription: "Job description")
        return ProfileScreenWorkExperienceCell(workExperience: workXP)
    }
}
#endif
