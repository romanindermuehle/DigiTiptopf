//
//  User.swift
//  DigiTiptopf
//
//  Created by Roman Indermühle on 08.11.2024.
//

import SwiftData
import Foundation

@Model
class User {
    var listStyle: ListStyle
    
    init(listStyle: ListStyle) {
        self.listStyle = listStyle
    }
}
