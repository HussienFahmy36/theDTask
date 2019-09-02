//
//  NetworkManagerErrors.swift
//  DdotAssignment
//
//  Created by Hussien Gamal Mohammed on 9/1/19.
//  Copyright © 2019 Ddot. All rights reserved.
//

import Foundation

enum DataLoaderErrors: Error {
    case noNetwork
    case urlNotFound
    case requestFailed
    case loadFromCacheFails
}
