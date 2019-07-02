//
//  WorkDetailsCoordinator.swift
//  IRCV
//
//  Created by Nuno Salvador on 17/06/2019.
//  Copyright © 2019 Nuno Salvador. All rights reserved.
//

import Foundation
import UIKit

protocol WorkDetailsRouting {
    
}

final class WorkDetailsCoordinator {
    private let builders: WorkDetailsScreenChildBuilders
    
    init(builders b: WorkDetailsScreenChildBuilders) {
        builders = b
    }
}

extension WorkDetailsCoordinator: WorkDetailsRouting {
    
}
