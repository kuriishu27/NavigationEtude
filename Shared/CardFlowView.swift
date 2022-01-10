//
//  MasterCardTabView.swift
//  NavigationEtude
//
//  Created by Christian Leovido on 10/01/2022.
//

import SwiftUI

struct CardFlowView: View {
    @ObservedObject var viewModel: ViewModel = ViewModel()
    
    var body: some View {
        List {
            NavigationLink(tag: CardStatus.apply, selection: $viewModel.status) {
                withAnimation {
                    ApplyView(selection: $viewModel.status)
                        .navigationBarBackButtonHidden(true)
                        .navigationTitle(Text("Apply"))
                }
            } label: {
                Text("Apply view")
            }
            
            NavigationLink(tag: CardStatus.activate, selection: $viewModel.status) {
                Button {
                    withAnimation {
                        viewModel.status = .addDebitCard
                    }
                } label: {
                    Text("Change to add debit view")
                }
                .navigationBarBackButtonHidden(true)
                .navigationTitle(Text("Activate"))
            } label: {
                Text("activate view")
            }
            
            NavigationLink(tag: CardStatus.addDebitCard, selection: $viewModel.status) {
                Button {
                    withAnimation {
                        viewModel.status = .topUp
                    }
                } label: {
                    Text("Change to topup view")
                }
                .navigationBarBackButtonHidden(true)
                .navigationTitle(Text("Add debit card"))
                
            } label: {
                Text("Top up")
            }
            
            NavigationLink(tag: CardStatus.topUp, selection: $viewModel.status) {
                if viewModel.status == .topUp {
                    Button {
                        withAnimation {
                            viewModel.status = .apply
                        }
                    } label: {
                        Text("top up view")
                    }
                    .navigationBarBackButtonHidden(true)
                    .navigationTitle(Text("Top up"))
                }
                
            } label: {
                Text("Add Debit Card")
            }
        }
    }
}

struct CardFlow_Previews: PreviewProvider {
    static var previews: some View {
        CardFlowView()
    }
}
