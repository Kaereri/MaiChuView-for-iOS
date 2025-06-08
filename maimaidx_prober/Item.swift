//
//  Item.swift
//  maimaidx_prober
//
//  Created by 枫羽云玲 on 2025/6/2.
//

import Foundation
import SwiftData

@Model
class User {
    var username: String
    var rating: Int
    var grade: String
    init(username: String,rating:Int,grade:String) {
        self.username = username
        self.rating = rating
        self.grade = grade
    }
}
