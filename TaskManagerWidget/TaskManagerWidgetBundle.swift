//
//  TaskManagerWidgetBundle.swift
//  TaskManagerWidget
//
//  Created by Can Kanbur on 1.06.2023.
//

import WidgetKit
import SwiftUI

@main
struct TaskManagerWidgetBundle: WidgetBundle {
    var body: some Widget {
        TaskManagerWidget()
        TaskManagerWidgetLiveActivity()
    }
}
