
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
        // ダミーのJSONデータをここにペースト
        // サンプルのJSONデータをペースト
        let jsonString = """
        {
            "count": 20,
            "filters": {},
            "competition": {
                "id": 2021,
                "area": {
                    "id": 2072,
                    "name": "England"
                },
                "name": "Premier League",
                "code": "PL",
                "plan": "TIER_ONE",
                "lastUpdated": "2022-03-20T08:58:54Z"
            },
            "season": {
                "id": 1564,
                "startDate": "2023-08-11",
                "endDate": "2024-05-19",
                "currentMatchday": 1,
                "winner": null
            },
            "teams": [
                {
                    "id": 57,
                    "area": {
                        "id": 2072,
                        "name": "England"
                    },
                    "name": "Arsenal FC",
                    "shortName": "Arsenal",
                    "tla": "ARS",
                    "crestUrl": "https://crests.football-data.org/57.png",
                    "address": "75 Drayton Park London N5 1BU",
                    "phone": "+44 (020) 76195003",
                    "website": "http://www.arsenal.com",
                    "email": "info@arsenal.co.uk",
                    "founded": 1886,
                    "clubColors": "Red / White",
                    "venue": "Emirates Stadium",
                    "lastUpdated": "2022-02-10T19:48:56Z"
                },
                {
                    "id": 58,
                    "area": {
                        "id": 2072,
                        "name": "England"
                    },
                    "name": "Aston Villa FC",
                    "shortName": "Aston Villa",
                    "tla": "AVL",
                    "crestUrl": "https://crests.football-data.org/58.png",
                    "address": "Villa Park Birmingham B6 6HE",
                    "phone": "+44 (0121) 3272299",
                    "website": "http://www.avfc.co.uk",
                    "email": null,
                    "founded": 1872,
                    "clubColors": "Claret / Sky Blue",
                    "venue": "Villa Park",
                    "lastUpdated": "2022-04-03T16:22:14Z"
                }
            ]
        }
        """

        // JSONデータをSwiftのData型に変換
        if let jsonData = jsonString.data(using: .utf8) {
            let decoder = JSONDecoder()
            do {
                // "teams"を指定してデコード
                let decodedData = try decoder.decode(TeamsData.self, from: jsonData)
                let teams = decodedData.teams
                completion(teams)
            } catch {
                print("Error decoding JSON: \(error)")
                completion([])
            }
        } else {
            print("Failed to convert JSON string to Data.")
            completion([])
        }
    }
}

struct Team: Decodable {
    let id: Int
    let name: String
    let shortName: String
    let tla: String
    let crestUrl: String
    let address: String?
    let phone: String?
    let website: String?
    let email: String?
    let founded: Int?
    let clubColors: String?
    let venue: String?
    let lastUpdated: String?
}
// "teams"に対応するデータ型
struct TeamsData: Decodable {
    let teams: [Team]
}
