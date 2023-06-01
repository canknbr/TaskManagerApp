//
//  NewTaskItemView.swift
//  TaskManagerApp
//
//  Created by Can Kanbur on 1.06.2023.
//

import SwiftUI

struct NewTaskItemView: View {
    @AppStorage("isDarkMode") var isDarkMode: Bool = false
    @Environment(\.managedObjectContext) private var viewContext
    @State var task: String = ""
    @Binding var isShowing: Bool
    private var isButtonDisabled: Bool {
        return task.isEmpty
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.task = task
            newItem.completion = false
            newItem.id = UUID()
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
            task = ""

            hideKeyboard()
            isShowing = false
        }
    }

    var body: some View {
        VStack {
            Spacer()
            VStack(spacing: 16) {
                TextField("New Task", text: $task)
                    .foregroundColor(.pink)
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.words)
                    .padding()
                    .background(
                        isDarkMode ? Color(UIColor.tertiarySystemBackground) : Color(UIColor.secondarySystemBackground)
                    )
                    .cornerRadius(10)

                Button {
                    addItem()
                    playSound(soundName: "sound-ding", soundType: "mp3")
                } label: {
                    Spacer()
                    Text("Save")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                    Spacer()
                }
                .disabled(isButtonDisabled)
                .onTapGesture {
                    if isButtonDisabled {
                        playSound(soundName: "sound-tap", soundType: "mp3")
                        feedback.notificationOccurred(.success)
                    }
                }
                .padding()

                .foregroundColor(.white)
                .background(isButtonDisabled ? .blue : .pink)
                .animation(.default, value: isButtonDisabled)
                .cornerRadius(20)

            }.padding(.horizontal)
                .padding(.vertical, 20)
                .background(
                    isDarkMode ? Color(UIColor.secondarySystemBackground) : .white
                )
                .cornerRadius(20)
                .shadow(color: .black.opacity(0.2), radius: 24)
                .frame(maxWidth: 640)
        }
        .padding()
    }
}

struct NewTaskItemView_Previews: PreviewProvider {
    static var previews: some View {
        NewTaskItemView(isShowing: .constant(true))
    }
}
