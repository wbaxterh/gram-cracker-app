//
//  Item.swift
//  GramCracker
//
//  Created by Wes Huber on 4/28/24.
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
