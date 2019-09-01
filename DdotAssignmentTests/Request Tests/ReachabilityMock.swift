//
//  ReachabilityMock.swift
//  DdotAssignmentTests
//
//  Created by Hussien Gamal Mohammed on 9/1/19.
//  Copyright © 2019 Ddot. All rights reserved.
//

import Foundation
@testable import DdotAssignment
struct ReachabilityMock: ReachabilityProtocol {
    public var setConnected = false
    func isConnectedToNetwork() -> Bool {
        return setConnected
    }
}
