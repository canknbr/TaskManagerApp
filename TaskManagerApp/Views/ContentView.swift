//
//  ContentView.swift
//  TaskManagerApp
//
//  Created by Can Kanbur on 1.06.2023.
//

import CoreData
import SwiftUI

struct ContentView: View {
    // MARK: - property

    @State var task: String = ""
    @State var showNewTaskItem: Bool = false
    @AppStorage("isDarkMode") var isDarkMode: Bool = false

    // MARK: - fething data

    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    // MARK: - function

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    // MARK: - body

    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    HStack(spacing: 10) {
                        Text("Devote")
                            .font(.system(.largeTitle, design: .rounded))
                            .fontWeight(.heavy)
                            .padding(.leading, 4)
                        Spacer()
                        EditButton()
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                            .padding(.horizontal, 10)
                            .frame(minWidth: 70, minHeight: 24)
                            .background(
                                Capsule()
                                    .stroke(.white, lineWidth: 2)
                            )
                        Button {
                            isDarkMode.toggle()
                            playSound(soundName: "sound-tap", soundType: "mp3")
                            feedback.notificationOccurred(.success)
                        } label: {
                            Image(systemName: isDarkMode ? "moon.circle.fill" : "moon.circle")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .font(.system(.title, design: .rounded))
                        }
                    }
                    .padding()
                    .foregroundColor(.white)
                    Spacer(minLength: 80)

                    Button {
                        showNewTaskItem = true
                        playSound(soundName: "sound-ding", soundType: "mp3")
                        feedback.notificationOccurred(.success)
                    } label: {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 30, weight: .semibold, design: .rounded))
                        Text("New Task")
                            .font(.system(size: 24, weight: .semibold, design: .rounded))

                    }.foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 15)
                        .background(
                            LinearGradient(colors: [Color.pink, .blue], startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                        .cornerRadius(25)

                    List {
                        ForEach(items) { item in
                         ListRowView(item: item)
                        }
                        .onDelete(perform: deleteItems)
                    } // list
                    .scrollContentBackground(.hidden)
                    .listStyle(InsetGroupedListStyle())
                    .shadow(color: .black.opacity(0.3), radius: 12, x: 0, y: 0)
                    .padding(.vertical, 0)
                    .frame(maxWidth: 640)
                } // vstack
                .blur(radius: showNewTaskItem ? 8 : 0, opaque: false)
                .transition(.move(edge: .bottom))
                .animation(.easeIn(duration: 0.5), value: showNewTaskItem)
                if showNewTaskItem {
                    BlankView(bgColor: isDarkMode ? .black : .gray, bgOpacity: isDarkMode ? 0.3 : 0.5)
                        .onTapGesture {
                            withAnimation {
                                showNewTaskItem = false
                            }
                        }
                    NewTaskItemView(isShowing: $showNewTaskItem)
                }
            } // zstack
            .navigationTitle("Daily Task")
            .toolbar(.hidden)
            .navigationBarTitleDisplayMode(.large)
            .background(
                BackgroundImageView()
                    .blur(radius: showNewTaskItem ? 8 : 0, opaque: false)
            )
            .background(
                backgroundGradient.ignoresSafeArea()
            )
        } // navigation
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
