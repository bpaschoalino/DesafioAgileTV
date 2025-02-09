//
//  SearchUserViewModel.swift
//  DesafioAgileTV
//
//  Created by Bruno Rodrigues on 08/02/25.
//

import Foundation

class SearchUserViewModel: ObservableObject {
    @Published var usernameToSearch: String = ""
    @Published var showErrorAlert = false
    @Published var errorMessage = ""
    @Published var user: User?
    @Published var repositories: [Repo]? = []
    
    private let service = Service()
    
    @MainActor
    func searchUser() async {
        guard !usernameToSearch.isEmpty else {
            errorMessage = "Please enter a username."
            showErrorAlert = true
            return
        }
        
        do {
            let result = await service.getRepos(user: usernameToSearch)
            switch result {
            case .success(let repos):
                guard let firstRepo = repos.first else {
                    errorMessage = "No public repositories found for this user."
                    showErrorAlert = true
                    return
                }
                
                user = User(
                    id: firstRepo.owner.id,
                    login: firstRepo.owner.login,
                    avatarUrl: firstRepo.owner.avatarUrl
                )
                repositories = repos
            case .failure(let error):
                errorMessage = mapNetworkError(error)
                showErrorAlert = true
            }
        }
    }
    
    private func mapNetworkError(_ error: NetworkError) -> String {
        switch error {
        case .badUrl:
            return "A network error has ocurred. Check your Internet connection and try again later."
        case .invalidRequest:
            return "A network error has ocurred. Check your Internet connection and try again later."
        case .badResponse:
            return "A network error has ocurred. Check your Internet connection and try again later."
        case .badStatus:
            return "User not found. Please enter another name."
        case .failedToDecodeResponse:
            return "A network error has ocurred. Check your Internet connection and try again later."
        }
    }
}
