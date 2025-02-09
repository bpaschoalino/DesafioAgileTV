//
//  ProfileDetailView.swift
//  DesafioAgileTV
//
//  Created by Bruno Rodrigues on 08/02/25.
//

import SwiftUI

struct ProfileDetailView: View {
    var user: User?
    var repositories: [Repo]?
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: user?.avatarUrl ?? "")) { image in
                if let avatar = image.image {
                    avatar
                        .resizable()
                        .frame(width: 170, height: 170)
                        .clipShape(Circle())
                        .shadow(radius: 1)
                } else {
                    ProgressView()
                }
            }
            Text(user?.login ?? "")
                .font(.headline)
            List(repositories ?? []) { repo in
                VStack {
                    Text(repo.name ?? "")
                        .font(.callout)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(repo.language ?? "Two or more languages found for this repository")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .contentMargins(.top, 4)
            .listRowSpacing(1.5)
        }
    }
}
