//
//  TeamsViewCombine.swift
//  football
//
//  Created by 遠藤拓弥 on 30.7.2023.
//

import Foundation
import SwiftUI
import Combine


struct TeamsViewCombine: View {
    @ObservedObject var presenter: TeamsPresenterCombine

    var body: some View {
        VStack {
            List(presenter.teams, id: \.id) { team in
                Text(team.name)
            }
            .onAppear { presenter.updateView() }
        }
    }
}


protocol TeamsPresenterCombineInterface {
    var teams: [Team] { get }
    func updateView()
}

class TeamsPresenterCombine: TeamsPresenterCombineInterface, ObservableObject {
    @Published var teams = [Team]()

    private var interactor: TeamsInteractorCombineInput
    private var cancellables: [AnyCancellable] = []


    init(interactor: TeamsInteractorCombineInput) {
        self.interactor = interactor
    }

    func updateView() {
        let teamsInteractor = TeamsInteractorCombine()

        teamsInteractor.fetchTeams()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    // Publisher finished successfully
                    break
                case .failure(let error):
                    // Error occurred during fetch
                    print("Error fetching teams: \(error)")
                }
            }, receiveValue: { teams in
                self.teams = teams
            }).store(in: &cancellables)
    }
}
