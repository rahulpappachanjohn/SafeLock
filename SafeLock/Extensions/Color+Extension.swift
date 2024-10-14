//
//  Color+Extension.swift
//  SafeLock
//
//  Created by Joshua Wegener on 14/10/24.
//

import SwiftUI

extension Color {
    static var correctPasswordField = LinearGradient(gradient: Gradient(colors: [.white.opacity(0.9), .green, .green]), startPoint: .top, endPoint: .bottom)
    static var wrongPasswordField = LinearGradient(gradient: Gradient(colors: [.white.opacity(0.9), .gray, .gray]), startPoint: .top, endPoint: .bottom)
    static var selectionIndiactor = LinearGradient(colors: [.white, .black, .black, .black, .white], startPoint: .topLeading, endPoint: .bottomTrailing)
    static var offWhite = Color(red: 225/255, green: 225/255, blue: 235/255)
}
