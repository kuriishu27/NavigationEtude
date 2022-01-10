//
//  ApplyView.swift
//  NavigationEtude
//
//  Created by Christian Leovido on 10/01/2022.
//

import SwiftUI

struct ApplyView: View {
    @Binding var selection: CardStatus?
    
    var body: some View {
        NavigationLink {
            VStack {
                NavigationLink {
                    Button {
                        selection = .activate
                    } label: {
                        Text("Finished. Activate status")
                    }
                } label: {
                    Text("User verification")
                }
            }
        } label: {
            Text("Product list")
        }
    }
}

struct ApplyView_Previews: PreviewProvider {
    @State static private var selection: CardStatus? = .apply
    static var previews: some View {
        ApplyView(selection: $selection)
    }
}
