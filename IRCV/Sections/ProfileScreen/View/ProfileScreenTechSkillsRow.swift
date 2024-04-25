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
        GeometryReader { geometryReader in
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 10) {
                    ForEach(self.items) { techSkill in
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
            .foregroundColor(.primary)
            .font(.caption)
    }
}

#if DEBUG
struct ProfileScreenTechSkillsRow_Previews: PreviewProvider {
    static var previews: some View {
        let items = [
            TechSkill(id: 1, name: "TechSkill1", score: 5),
            TechSkill(id: 2, name: "TechSkill2", score: 5),
            TechSkill(id: 3, name: "TechSkill3", score: 5),
            TechSkill(id: 4, name: "TechSkill4", score: 5),
            TechSkill(id: 5, name: "TechSkill5", score: 5),
            TechSkill(id: 6, name: "TechSkill6", score: 5),
            TechSkill(id: 7, name: "TechSkill7", score: 5),
            TechSkill(id: 8, name: "TechSkill8", score: 5)
        ]
        ProfileScreenTechSkillsRow(items: items)
    }
}
#endif
