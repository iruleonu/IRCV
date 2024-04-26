//
//  RootBuilder.swift
//  IRShowcase
//
//  Created by Nuno Salvador on 20/03/2019.
//  Copyright © 2019 Nuno Salvador. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

protocol RootChildBuilders {
    func makeMainScreen() -> UIViewController
    func makeOnBoarding() -> UIViewController
}

struct RootBuilder: RootChildBuilders {
    func make(window: UIWindow) -> RootCoordinator {
        return RootCoordinator(window: window, builders: self)
    }
    
    @MainActor func makeMainScreen() -> UIViewController {
        let network = APIServiceImpl.default
        let view = ProfileScreenBuilder().make(network: network)
        return UIHostingController(rootView: view)
    }
    
    @MainActor func makeOnBoarding() -> UIViewController {
        // TODO: on boarding
        let network = APIServiceImpl.default
        let view = ProfileScreenBuilder().make(network: network)
        return UIHostingController(rootView: view)
    }
}
