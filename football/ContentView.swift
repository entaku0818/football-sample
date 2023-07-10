
import SwiftUI


struct TeamsView: View {
    @ObservedObject var presenter: TeamsPresenter

    var body: some View {
        VStack {
            List(presenter.teams, id: \.id) { team in
                Text(team.name)
            }
            .onAppear { presenter.updateView() }
        }
    }
}


protocol TeamsPresenterInterface {
    var teams: [Team] { get }
    func updateView()
}

class TeamsPresenter: TeamsPresenterInterface, ObservableObject {
    @Published var teams = [Team]()

    private var interactor: TeamsInteractorInput

    init(interactor: TeamsInteractorInput) {
        self.interactor = interactor
    }

    func updateView() {
        interactor.fetchTeams { fetchedTeams in
            self.teams = fetchedTeams
        }
    }
}


protocol TeamsInteractorInput {
    func fetchTeams(completion: @escaping ([Team]) -> Void)
}

class TeamsInteractor: TeamsInteractorInput {
    func fetchTeams(completion: @escaping ([Team]) -> Void) {
        // Fetch teams from an API. Here we use dummy data.
        let teams = [Team(id: 1, name: "Team 1", venue: "Venue 1")]
        completion(teams)
    }
}


struct Team {
    let id: Int
    let name: String
    let venue: String
    // other properties
}
