//
//  ContentView.swift
//  Shared
//
//  Created by Amethyst Raven Sky Wyld on 08/01/2022.
//

import SwiftUI

enum Route: Hashable {
    case home
    case orders
    case takeaway
    case newOrder
}

struct HomeView: View {
    @Binding var route: Route?

    var body: some View {
        OrderView(parentRoute: $route)
            .navigationTitle("Home")
    }
}

struct NewOrderView: View {
    @Binding var parentRoute: Route?

    var body: some View {
        VStack {
            Button {
                parentRoute = .home
            } label: {
                Text("Go back home")
            }
        }
    }
}

struct OrderView: View {
    
    @Binding var parentRoute: Route?
    @State var route: Route?
    
    var body: some View {
        NavigationLink(tag: Route.newOrder,
                       selection: $route) {
            NewOrderView(parentRoute: $parentRoute)
        } label: {
            Text("make new order view")
        }
    }
}

struct ContentView: View {
    
    @State var route: Route? = .home
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink(
                    tag: Route.home,
                    selection: $route
                ) {
                    HomeView(route: $route)
                } label: {
                    Text("Home")
                }

                
                Button {
                    route = .newOrder
                } label: {
                    NavigationLink(
                        tag: Route.newOrder,
                        selection: $route
                    ) {
                        OrderView(parentRoute: $route, route: .newOrder)
                    } label: {
                        Text("Make new order")
                    }
                }
                
                NavigationLink(
                    tag: Route.orders,
                    selection: $route
                ) {
                    OrderView(parentRoute: $route)
                } label: {
                    Text("Orders")
                }
                
                NavigationLink(
                    tag: Route.takeaway,
                    selection: $route
                ) {
                    Text("Takeaway")
                } label: {
                    Text("Takeaway")
                }
            }
            .listStyle(SidebarListStyle())
            .navigationBarItems(leading: Text("Some"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Mail: Identifiable, Hashable {
    let id = UUID()
    let date: Date
    let subject: String
    let body: String
    var isFavorited = false
}

final class MailStore: ObservableObject {
    @Published var allMails: [String: [Mail]] = [
        "Inbox": [ .init(date: Date(), subject: "Subject1", body: "Very long body...") ],
        "Sent": [ .init(date: Date(), subject: "Subject2", body: "Very long body...") ],
    ]
}

struct Sidebar: View {
    @ObservedObject var store: MailStore
    @Binding var selectedFolder: String?
    @Binding var selectedMail: Mail?

    var body: some View {
        List {
            ForEach(Array(store.allMails.keys), id: \.self) { folder in
                NavigationLink(
                    destination: FolderView(
                        title: folder,
                        mails: store.allMails[folder, default: []],
                        selectedMail: $selectedMail
                    ),
                    tag: folder,
                    selection: $selectedFolder
                ) {
                    Text(folder).font(.headline)
                }
            }
        }.listStyle(SidebarListStyle())
            .navigationBarTitle("Some")
    }
}

struct FolderView: View {
    let title: String
    let mails: [Mail]
    @Binding var selectedMail: Mail?

    var body: some View {
        List {
            ForEach(mails) { mail in
                NavigationLink(
                    destination: MailView(mail: mail),
                    tag: mail,
                    selection: $selectedMail
                ) {
                    VStack(alignment: .leading) {
                        Text(mail.subject)
                        Text(mail.date, style: .date)
                    }
                }
            }
        }.navigationTitle(title)
    }
}


struct MailView: View {
    let mail: Mail

    var body: some View {
        VStack(alignment: .leading) {
            Text(mail.subject)
                .font(.headline)
            Text(mail.date, style: .date)
            Text(mail.body)
        }
    }
}
