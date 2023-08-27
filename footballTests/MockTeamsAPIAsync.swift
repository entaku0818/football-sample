//
//  MockTeamsAPIAsync.swift
//  footballTests
//
//  Created by 遠藤拓弥 on 27.8.2023.
//

import Foundation
@testable import football

class MockTeamsAPIAsync: TeamsAPIAsync {
    override func fetchTeams() async throws -> [Team] {
        // テスト用のダミーデータを返す
        let dummyTeam1 = Team(id: 1,
                              name: "Team A",
                              shortName: "TA",
                              tla: "T",
                              crest: "crest1",
                              address: "123 Main St",
                              phone: "123-456-7890",
                              website: "http://www.team-a.com",
                              email: "contact@team-a.com",
                              founded: 2000,
                              clubColors: "Red, White",
                              venue: "Stadium A",
                              lastUpdated: "2023-08-27")

        let dummyTeam2 = Team(id: 2,
                              name: "Team B",
                              shortName: "TB",
                              tla: "B",
                              crest: "crest2",
                              address: "456 Elm St",
                              phone: "987-654-3210",
                              website: "http://www.team-b.com",
                              email: "contact@team-b.com",
                              founded: 1995,
                              clubColors: "Blue, Yellow",
                              venue: "Stadium B",
                              lastUpdated: "2023-08-27")

        // ダミーデータの配列
        let dummyTeams = [dummyTeam1, dummyTeam2]
        return dummyTeams
    }
}
