//
//  NavigationEtudeApp.swift
//  Shared
//
//  Created by Amethyst Raven Sky Wyld on 08/01/2022.
//

import SwiftUI

@main
struct NavigationEtudeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}


//@main
//struct TestProjectApp: App {
//    @StateObject var store = MailStore()
//    @State private var selectedLabel: String? = "Inbox"
//    @State private var selectedMail: Mail?
//
//    var body: some Scene {
//        WindowGroup {
//            NavigationView {
//                Sidebar(
//                    store: store,
//                    selectedFolder: $selectedLabel,
//                    selectedMail: $selectedMail
//                )
//
//                Text("Select label...")
//                Text("Select mail...")
//            }
//        }
//    }
//}
