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
    @State private var selectedTeam: Team? = nil


    var body: some View {
        VStack {
            List(presenter.teams, id: \.id) { team in
                NavigationLink(destination: TeamDetailView(team: team), tag: team, selection: $selectedTeam) {
                    Text(team.name)
                }
            }
            .onAppear {
                Task {
                  do {
                      try await presenter.updateView()
                  } catch {
                      print("Error fetching teams: \(error)")
                  }
                }
            }
            Spacer()
        }
    }
}


protocol TeamsPresenterAsyncInterface {
    var teams: [Team] { get }
    func updateView() async throws
}

class TeamsPresenterAsync: TeamsPresenterAsyncInterface, ObservableObject {

    @Published var teams = [Team]()
    private var interactor: TeamsAPIAsync


    init(interactor: TeamsAPIAsync) {
        self.interactor = interactor
    }

    @MainActor
    func updateView() async throws {
        self.teams = try await interactor.fetchTeams()
    }
}




