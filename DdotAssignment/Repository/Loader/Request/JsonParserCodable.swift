//
//  JsonParserCodable.swift
//  DdotAssignment
//
//  Created by Hussien Gamal Mohammed on 9/1/19.
//  Copyright © 2019 Ddot. All rights reserved.
//

import Foundation

public class JsonParserCodable {
    public func parse<T: Codable>(data: Data?, to target: T.Type) -> T? {
        let decoder = JSONDecoder()
        guard let dataToParse = data else {
            return nil
        }
        do {
            let decodedData = try decoder.decode(T.self, from: dataToParse)
            return decodedData
        } catch let error {
            print(error)
        }
        return nil
    }
    public init() {

    }
}
