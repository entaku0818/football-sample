//
//  Teams.swift
//  football
//
//  Created by 遠藤拓弥 on 3.9.2023.
//

import Foundation
struct Team: Decodable, Identifiable, Hashable {
    let id: Int
    let name: String
    let shortName: String
    let tla: String
    let crest: String
    let address: String?
    let phone: String?
    let website: String?
    let email: String?
    let founded: Int?
    let clubColors: String?
    let venue: String?
    let lastUpdated: String?
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: Team, rhs: Team) -> Bool {
        lhs.id == rhs.id
    }
}

struct TeamDetail: Codable, Identifiable {

    struct Player: Codable, Identifiable {
        let id: Int

        let name: String
        let position: String?
        let dateOfBirth: String
        let nationality: String?
        let shirtNumber: Int?
        let marketValue: Int?
    }


    let id: Int
    let name: String
    let shortName: String
    let tla: String
    let address: String?
    let website: String?
    let founded: Int?
    let clubColors: String?
    let venue: String?
    let squad: [Player]
}


// "teams"に対応するデータ型
struct TeamsData: Decodable {
    let teams: [Team]

    private enum CodingKeys: String, CodingKey {
        case teams = "teams"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        teams = try container.decode([Team].self, forKey: .teams)
    }
}
