//
//  Constant.swift
//  TaskManagerApp
//
//  Created by Can Kanbur on 1.06.2023.
//

import SwiftUI

// MARK: - formatter

let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()


//MARK: - ui
var backgroundGradient : LinearGradient{
    return LinearGradient(colors: [Color.pink,.blue], startPoint: .topLeading, endPoint: .bottomTrailing)
}

//MARK: - ux

let feedback = UINotificationFeedbackGenerator()
