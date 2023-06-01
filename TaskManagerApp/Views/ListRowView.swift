//
//  ListRowView.swift
//  TaskManagerApp
//
//  Created by Can Kanbur on 1.06.2023.
//

import SwiftUI

struct ListRowView: View {
    @Environment(\.managedObjectContext) var viewContext
    @ObservedObject var item : Item
    var body: some View {
        Toggle(isOn: $item.completion) {
            Text(item.task ?? "")
                .font(.system(.title2,design: .rounded))
                .fontWeight(.heavy)
                .foregroundColor(item.completion ? .pink : .primary)
                .padding(.vertical,12)
                .animation(.default, value: item.completion)
        }
        .toggleStyle(CheckBoxStyle())
        .onReceive(item.objectWillChange) { _ in
            if self .viewContext.hasChanges {
                try? self.viewContext.save()
            }
        }
    }
}

