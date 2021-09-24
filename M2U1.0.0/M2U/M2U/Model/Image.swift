//
//  Image.swift
//  M2U
//
//  Created by Yan Akhrameev on 22/09/21.
//

import Foundation

struct Image {
    let posters: [Images]
}

struct Images {
    let image: String
    enum CodingKeys: String, CodingKey {
        case image = "file_path"
    }
}


