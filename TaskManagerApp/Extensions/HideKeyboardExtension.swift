//
//  HideKeyboardExtension.swift
//  TaskManagerApp
//
//  Created by Can Kanbur on 1.06.2023.
//

import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
