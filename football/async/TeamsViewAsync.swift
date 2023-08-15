//
//  TeamsViewAsync.swift
//  football
//
//  Created by 遠藤拓弥 on 15.8.2023.
//

import Foundation
import SwiftUI
import Combine


struct TeamsViewAsync: View {
    @ObservedObject var presenter: TeamsPresenterAsync

    var body: some View {
        VStack {
            List(presenter.teams, id: \.id) { team in
                Text(team.name)
            }
            .onAppear { presenter.updateView() }
        }
    }
}


protocol TeamsPresenterAsyncInterface {
    var teams: [Team] { get }
    func updateView()
}

class TeamsPresenterAsync: TeamsPresenterAsyncInterface, ObservableObject {
    @Published var teams = [Team]()
    private var cancellables: [AnyCancellable] = []

    private var interactor: TeamsAPIAsync


    init(interactor: TeamsAPIAsync) {
        self.interactor = TeamsAPIAsync()
    }

    func updateView() {
        Task { [weak self] in
            guard let self = self else { return }

            do {
                let fetchedTeams = try await interactor.fetchTeams()
                await MainActor.run {
                    self.teams = fetchedTeams
                }
            } catch {
                print("Error fetching teams: \(error)")
            }
        }
    }
}




