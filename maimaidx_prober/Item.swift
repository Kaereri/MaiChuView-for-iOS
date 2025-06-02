//
//  Item.swift
//  maimaidx_prober
//
//  Created by 枫羽云玲 on 2025/6/2.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
