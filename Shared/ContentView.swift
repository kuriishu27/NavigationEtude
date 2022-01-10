//
//  ContentView.swift
//  Shared
//
//  Created by Christian Ray Leovido on 08/01/2022.
//

import SwiftUI

enum CardStatus: String {
    case apply
    case activate
    case addDebitCard
    case topUp
}

enum Route: Hashable {
    case home
    case orders
    case takeaway
    case newOrder
}

final class ViewModel: ObservableObject {
    @Published var status: CardStatus? = .apply
    
    public init() {}
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
                parentRoute = nil
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
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
