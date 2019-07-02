//
//  ProfileScreenTechSkillsRow.swift
//  IRCV
//
//  Created by Nuno Salvador on 17/06/2019.
//  Copyright © 2019 Nuno Salvador. All rights reserved.
//

import SwiftUI

struct ProfileScreenTechSkillsRow: View {
    var items: [TechSkill]
    
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView(showsHorizontalIndicator: false) {
                HStack(alignment: .top, spacing: 10) {
                    ForEach(self.items.identified(by: \.name)) { techSkill in
                        ProfileScreenTechSkillsItem(techSkill: techSkill.name)
                    }
                }
            }
        }
    }
}

struct ProfileScreenTechSkillsItem: View {
    var techSkill: String
    
    var body: some View {
        Text(techSkill)
            .color(.primary)
            .font(.caption)
    }
}

#if DEBUG
struct ProfileScreenTechSkillsRow_Previews: PreviewProvider {
    static var previews: some View {
        ProfileScreenTechSkillsRow(items: [TechSkill(id: 1, name: "na", score: 5), TechSkill(id: 2, name: "2", score: 5)])
    }
}
#endif
