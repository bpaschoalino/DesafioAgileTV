//
//  ContentView.swift
//  DesafioAgileTV
//
//  Created by Bruno Rodrigues on 07/02/25.
//

import SwiftUI

struct SearchUserView: View {
    @State private var showUserDetail: Bool = false
    @StateObject var searchUserViewModel = SearchUserViewModel()
    
    func updateShowUserDetailFlag() -> Text {
        showUserDetail = false
        return Text("OK")
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("GitHub Viewer")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .center)
                    .fixedSize(horizontal: false, vertical: true)
                
                Spacer()
                
                TextField("Username",text: $searchUserViewModel.usernameToSearch)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .shadow(radius: 2)
                
                Button("Search") {
                    Task {
                        await searchUserViewModel.searchUser()
                        showUserDetail = true
                    }
                }
                .font(.title)
                .padding()
                .navigationDestination(isPresented: $showUserDetail) {
                    ProfileDetailView(user: searchUserViewModel.user, repositories: searchUserViewModel.repositories)
                }
                
                Spacer(minLength: 300)
            }
        }
        .alert("Error", isPresented: $searchUserViewModel.showErrorAlert) {
            Button("Ok") {
                showUserDetail = false
            }
        } message: {
            Text(searchUserViewModel.errorMessage)
        }
    }
}

#Preview {
    SearchUserView()
}
