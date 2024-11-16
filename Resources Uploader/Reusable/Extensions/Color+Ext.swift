//
//  Color+Ext.swift
//  Resources Uploader
//
//  Created by Kavinda Dilshan on 2024-11-15.
//

import SwiftUICore

extension Color {
    static var debug: Color {
        let red: Double = .random(in: 0...1)
        let green: Double = .random(in: 0...1)
        let blue: Double = .random(in: 0...1)
        return .init(red: red, green: green, blue: blue)
    }
}
