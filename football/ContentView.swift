
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
                },
                {
                    "id": 61,
                    "area": {
                        "id": 2072,
                        "name": "England"
                    },
                    "name": "Chelsea FC",
                    "shortName": "Chelsea",
                    "tla": "CHE",
                    "crestUrl": "https://crests.football-data.org/61.png",
                    "address": "Fulham Road London SW6 1HS",
                    "phone": "+44 (0871) 9841955",
                    "website": "http://www.chelseafc.com",
                    "email": null,
                    "founded": 1905,
                    "clubColors": "Royal Blue / White",
                    "venue": "Stamford Bridge",
                    "lastUpdated": "2022-02-10T19:24:40Z"
                },
                {
                    "id": 62,
                    "area": {
                        "id": 2072,
                        "name": "England"
                    },
                    "name": "Everton FC",
                    "shortName": "Everton",
                    "tla": "EVE",
                    "crestUrl": "https://crests.football-data.org/62.png",
                    "address": "Goodison Park Liverpool L4 4EL",
                    "phone": "+44 (0871) 6631878",
                    "website": "http://www.evertonfc.com",
                    "email": "everton@evertonfc.com",
                    "founded": 1878,
                    "clubColors": "Blue / White",
                    "venue": "Goodison Park",
                    "lastUpdated": "2022-02-10T19:47:42Z"
                },
                {
                    "id": 63,
                    "area": {
                        "id": 2072,
                        "name": "England"
                    },
                    "name": "Fulham FC",
                    "shortName": "Fulham",
                    "tla": "FUL",
                    "crestUrl": "https://crests.football-data.org/63.svg",
                    "address": "Craven Cottage, Stevenage Road London SW6 6HH",
                    "phone": "+44 (0870) 4421222",
                    "website": "http://www.fulhamfc.com",
                    "email": "enquiries@fulhamfc.com",
                    "founded": 1879,
                    "clubColors": "White / Black",
                    "venue": "Craven Cottage",
                    "lastUpdated": "2021-04-09T02:26:44Z"
                },
                {
                    "id": 64,
                    "area": {
                        "id": 2072,
                        "name": "England"
                    },
                    "name": "Liverpool FC",
                    "shortName": "Liverpool",
                    "tla": "LIV",
                    "crestUrl": "https://crests.football-data.org/64.png",
                    "address": "Anfield Road Liverpool L4 0TH",
                    "phone": "+44 (0844) 4993000",
                    "website": "http://www.liverpoolfc.tv",
                    "email": "customercontact@liverpoolfc.tv",
                    "founded": 1892,
                    "clubColors": "Red / White",
                    "venue": "Anfield",
                    "lastUpdated": "2022-02-10T19:30:22Z"
                },
                {
                    "id": 65,
                    "area": {
                        "id": 2072,
                        "name": "England"
                    },
                    "name": "Manchester City FC",
                    "shortName": "Man City",
                    "tla": "MCI",
                    "crestUrl": "https://crests.football-data.org/65.png",
                    "address": "SportCity Manchester M11 3FF",
                    "phone": "+44 (0870) 0621894",
                    "website": "https://www.mancity.com",
                    "email": "mancity@mancity.com",
                    "founded": 1880,
                    "clubColors": "Sky Blue / White",
                    "venue": "Etihad Stadium",
                    "lastUpdated": "2022-02-10T19:48:37Z"
                },
                {
                    "id": 66,
                    "area": {
                        "id": 2072,
                        "name": "England"
                    },
                    "name": "Manchester United FC",
                    "shortName": "Man United",
                    "tla": "MUN",
                    "crestUrl": "https://crests.football-data.org/66.png",
                    "address": "Sir Matt Busby Way Manchester M16 0RA",
                    "phone": "+44 (0161) 8688000",
                    "website": "http://www.manutd.com",
                    "email": "enquiries@manutd.co.uk",
                    "founded": 1878,
                    "clubColors": "Red / White",
                    "venue": "Old Trafford",
                    "lastUpdated": "2022-02-10T19:27:46Z"
                },
                {
                    "id": 67,
                    "area": {
                        "id": 2072,
                        "name": "England"
                    },
                    "name": "Newcastle United FC",
                    "shortName": "Newcastle",
                    "tla": "NEW",
                    "crestUrl": "https://crests.football-data.org/67.png",
                    "address": "Sports Direct Arena Newcastle upon Tyne NE1 4ST",
                    "phone": null,
                    "website": "http://www.nufc.co.uk",
                    "email": "admin@nufc.co.uk",
                    "founded": 1881,
                    "clubColors": "Black / White",
                    "venue": "St. James' Park",
                    "lastUpdated": "2022-09-28T18:51:07Z"
                },
                {
                    "id": 73,
                    "area": {
                        "id": 2072,
                        "name": "England"
                    },
                    "name": "Tottenham Hotspur FC",
                    "shortName": "Tottenham",
                    "tla": "TOT",
                    "crestUrl": "https://crests.football-data.org/73.svg",
                    "address": "Bill Nicholson Way, 748 High Road London N17 0AP",
                    "phone": "+44 (0844) 4995000",
                    "website": "http://www.tottenhamhotspur.com",
                    "email": "customer.care@tottenhamhotspur.com",
                    "founded": 1882,
                    "clubColors": "Navy Blue / White",
                    "venue": "Tottenham Hotspur Stadium",
                    "lastUpdated": "2020-11-20T07:12:32Z"
                },
                {
                    "id": 76,
                    "area": {
                        "id": 2072,
                        "name": "England"
                    },
                    "name": "Wolverhampton Wanderers FC",
                    "shortName": "Wolverhampton",
                    "tla": "WOL",
                    "crestUrl": "https://crests.football-data.org/76.svg",
                    "address": "Waterloo Road Wolverhampton WV1 4QR",
                    "phone": "+44 (0871) 2222220",
                    "website": "http://www.wolves.co.uk",
                    "email": "info@wolves.co.uk",
                    "founded": 1877,
                    "clubColors": "Black / Gold",
                    "venue": "Molineux Stadium",
                    "lastUpdated": "2021-04-09T02:25:24Z"
                },
                {
                    "id": 328,
                    "area": {
                        "id": 2072,
                        "name": "England"
                    },
                    "name": "Burnley FC",
                    "shortName": "Burnley",
                    "tla": "BUR",
                    "crestUrl": "https://crests.football-data.org/328.png",
                    "address": "Harry Potts Way Burnley BB10 4BX",
                    "phone": "+44 (0871) 2211882",
                    "website": "http://www.burnleyfootballclub.com",
                    "email": "info@burnleyfc.com",
                    "founded": 1881,
                    "clubColors": "Claret / Sky Blue",
                    "venue": "Turf Moor",
                    "lastUpdated": "2022-02-10T19:24:11Z"
                },
                {
                    "id": 351,
                    "area": {
                        "id": 2072,
                        "name": "England"
                    },
                    "name": "Nottingham Forest FC",
                    "shortName": "Nottingham",
                    "tla": "NOT",
                    "crestUrl": "https://crests.football-data.org/351.png",
                    "address": "Pavilion Road, West Bridgeford Nottingham NG2 5GJ",
                    "phone": "+44 (0115) 9824444",
                    "website": "http://www.nottinghamforest.co.uk",
                    "email": "enquiries@nottinghamforest.co.uk",
                    "founded": 1865,
                    "clubColors": "Red / White",
                    "venue": "The City Ground",
                    "lastUpdated": "2022-07-26T17:53:21Z"
                },
                {
                    "id": 354,
                    "area": {
                        "id": 2072,
                        "name": "England"
                    },
                    "name": "Crystal Palace FC",
                    "shortName": "Crystal Palace",
                    "tla": "CRY",
                    "crestUrl": "https://crests.football-data.org/354.png",
                    "address": "Whitehorse Lane London SE25 6PU",
                    "phone": "+44 (020) 87686000",
                    "website": "http://www.cpfc.co.uk",
                    "email": "info@cpfc.co.uk",
                    "founded": 1905,
                    "clubColors": "Red / Blue",
                    "venue": "Selhurst Park",
                    "lastUpdated": "2022-02-10T19:22:36Z"
                },
                {
                    "id": 356,
                    "area": {
                        "id": 2072,
                        "name": "England"
                    },
                    "name": "Sheffield United FC",
                    "shortName": "Sheffield Utd",
                    "tla": "SHE",
                    "crestUrl": "https://crests.football-data.org/356.svg",
                    "address": "Bramall Lane Sheffield, Yorkshire S2 4SU",
                    "phone": "+44 (0871) 9951899",
                    "website": "http://www.sufc.co.uk",
                    "email": "info@sufc.co.uk",
                    "founded": null,
                    "clubColors": "Red / White / Black",
                    "venue": "Bramall Lane",
                    "lastUpdated": "2020-11-26T02:14:35Z"
                },
                {
                    "id": 389,
                    "area": {
                        "id": 2072,
                        "name": "England"
                    },
                    "name": "Luton Town FC",
                    "shortName": "Luton Town",
                    "tla": "LUT",
                    "crestUrl": "https://crests.football-data.org/389.png",
                    "address": "1 Maple Road Luton LU4 8AW",
                    "phone": "+44 (01582) 411622",
                    "website": "http://www.lutontown.co.uk",
                    "email": null,
                    "founded": 1885,
                    "clubColors": "White / Navy Blue / Orange",
                    "venue": "Kenilworth Road Stadium",
                    "lastUpdated": "2022-02-19T08:50:08Z"
                },
                {
                    "id": 397,
                    "area": {
                        "id": 2072,
                        "name": "England"
                    },
                    "name": "Brighton & Hove Albion FC",
                    "shortName": "Brighton Hove",
                    "tla": "BHA",
                    "crestUrl": "https://crests.football-data.org/397.svg",
                    "address": "44 North Road Brighton & Hove BN1 1YR",
                    "phone": "+44 (01273) 878288",
                    "website": "http://www.seagulls.co.uk",
                    "email": "seagulls@bhafc.co.uk",
                    "founded": 1898,
                    "clubColors": "Blue / White",
                    "venue": "The American Express Community Stadium",
                    "lastUpdated": "2021-04-12T13:10:44Z"
                },
                {
                    "id": 402,
                    "area": {
                        "id": 2072,
                        "name": "England"
                    },
                    "name": "Brentford FC",
                    "shortName": "Brentford",
                    "tla": "BRE",
                    "crestUrl": "https://crests.football-data.org/402.png",
                    "address": "Braemar Road Brentford TW8 0NT",
                    "phone": null,
                    "website": "http://www.brentfordfc.co.uk",
                    "email": "enquiries@brentfordfc.co.uk",
                    "founded": 1889,
                    "clubColors": "Red / White / Black",
                    "venue": "Griffin Park",
                    "lastUpdated": "2022-04-03T16:24:00Z"
                },
                {
                    "id": 563,
                    "area": {
                        "id": 2072,
                        "name": "England"
                    },
                    "name": "West Ham United FC",
                    "shortName": "West Ham",
                    "tla": "WHU",
                    "crestUrl": "https://crests.football-data.org/563.png",
                    "address": "Queen Elizabeth Olympic Park, London London E20 2ST",
                    "phone": "+44 (020) 85482794",
                    "website": "http://www.whufc.com",
                    "email": "yourcomments@westhamunited.co.uk",
                    "founded": 1895,
                    "clubColors": "Claret / Sky Blue",
                    "venue": "London Stadium",
                    "lastUpdated": "2022-02-19T08:09:25Z"
                },
                {
                    "id": 1044,
                    "area": {
                        "id": 2072,
                        "name": "England"
                    },
                    "name": "AFC Bournemouth",
                    "shortName": "Bournemouth",
                    "tla": "BOU",
                    "crestUrl": "https://crests.football-data.org/1044.png",
                    "address": "Dean Court, Kings Park Bournemouth BH7 7AF",
                    "phone": "+44 (01202) 726300",
                    "website": "http://www.afcb.co.uk",
                    "email": "admin@afcb.co.uk",
                    "founded": 1890,
                    "clubColors": "Red / Black",
                    "venue": "Vitality Stadium",
                    "lastUpdated": "2022-02-22T14:05:46Z"
                }
            ]
        }
        """

        // JSONデータをSwiftのData型に変換
        if let jsonData = jsonString.data(using: .utf8) {
            let decoder = JSONDecoder()
            do {
                let teams = try decoder.decode([Team].self, from: jsonData)
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
