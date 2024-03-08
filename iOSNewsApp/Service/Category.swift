//
//  Category.swift
//  iOSNewsApp
//
//  Created by Evita Sihombing on 29/02/24.
//

import Foundation

struct Category: Codable {
    let id: Int
    let isActive: Bool
    let name: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case isActive = "is_active"
        case name
    }
}
