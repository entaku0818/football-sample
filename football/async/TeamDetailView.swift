//
//  TeamDetailView.swift
//  football
//
//  Created by 遠藤拓弥 on 3.9.2023.
//
import SwiftUI
import Foundation

struct TeamDetailView: View {
    var team: Team
    @StateObject var presenter: TeamDetailPresenterAsync

    init(team:Team, teamId: Int) {
        let interactor = TeamsAPIAsync() // インターフェースの初期化方法に合わせて変更してください
        self._presenter = StateObject(wrappedValue: TeamDetailPresenterAsync(interactor: interactor, teamId: teamId))
        self.team = team
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack(alignment: .center){
                    Spacer()
                    if let imageUrl = URL(string: team.crest) {
                        AsyncImage(url: imageUrl) { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(maxHeight: 150)
                    }
                    Spacer()
                }
                
                Text("Team Detail: \(team.name)")
                    .font(.headline)
                Text("Short Name: \(team.shortName)")
                    .font(.subheadline)
                Text("TLA: \(team.tla)")
                    .font(.subheadline)
                Text("Founded: \(team.founded ?? 0)")
                    .font(.subheadline)
                // Display other properties as needed
                
                Text("Players:")
                    .font(.headline)
                    .padding(.top)
                
                ForEach(presenter.team?.squad ?? [], id: \.id) { player in
                    VStack(alignment: .leading) {
                        Text(player.name)
                            .font(.subheadline)
                        Text("Position: \(player.position ?? "N/A")")
                            .font(.subheadline)
                    }
                }
                Spacer()
                
            }.onAppear {
                Task {
                    do {
                        try await presenter.updateView()
                    } catch {
                        print("Error fetching teams: \(error)")
                    }
                }
            }
        }
    }
}


protocol TeamDetailPresenterAsyncInterface {
    var team: TeamDetail? { get }
    func updateView() async throws
}

class TeamDetailPresenterAsync: TeamDetailPresenterAsyncInterface, ObservableObject {

    @Published var team: TeamDetail?
    private var interactor: TeamsAPIAsync
    private let teamId:Int


    init(interactor: TeamsAPIAsync, teamId:Int) {
        self.interactor = interactor
        self.teamId = teamId
    }

    @MainActor
    func updateView() async throws {
        self.team = try await interactor.fetchTeamDetail(teamId: teamId)
    }
}
