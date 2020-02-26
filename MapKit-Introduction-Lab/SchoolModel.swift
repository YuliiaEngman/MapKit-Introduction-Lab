//
//  SchoolModel.swift
//  MapKit-Introduction-Lab
//
//  Created by Yuliia Engman on 2/25/20.
//  Copyright © 2020 Yuliia Engman. All rights reserved.
//

import Foundation

struct ModelForNYCSchools: Codable {
    let results: [Schools]
}

struct Schools: Codable {
    let schoolName: String
    let latitude: String
    let longitude: String
    private enum CodingKeys: String, CodingKey {
        case schoolName = "school_name"
        case latitude
        case longitude
}
}


