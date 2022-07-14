//
//  Model.swift
//  Task19JsonAlamofireURL
//
//  Created by Ilia Zakharov on 07.07.2022.
//


//{
//"birth": 1987,
//"occupation": "Artist",
//"name": "Kiyohara",
//"lastname": "Yukinobu",
//"country": "Russia"
//}

import Foundation

struct InfoModel: Codable {
    
    let birth: Int
    let occupation: String
    let name: String
    let lastName: String
    let country: String
}
