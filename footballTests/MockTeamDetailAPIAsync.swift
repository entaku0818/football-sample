//
//  MockTeamsAPIAsync.swift
//  footballTests
//
//  Created by 遠藤拓弥 on 27.8.2023.
//


import Foundation
@testable import football

class MockTeamDetailAPIAsync: TeamsAPIAsync {

    var mockFetchTeamDetailResult: TeamDetail?
    var mockFetchTeamDetailError: Error?

    override func fetchTeamDetail(teamId: Int) async throws -> TeamDetail {
        if let error = mockFetchTeamDetailError {
            throw error
        }
        if let result = mockFetchTeamDetailResult {
            return result
        }
        let player1 = TeamDetail.Player(id: 1, name: "John Doe", position: "Forward", dateOfBirth: "1990-01-01", nationality: "USA", shirtNumber: 10, marketValue: 1000000)
        let player2 = TeamDetail.Player(id: 2, name: "Jane Smith", position: "Midfielder", dateOfBirth: "1992-05-15", nationality: "England", shirtNumber: 7, marketValue: 800000)
        let squad = [player1, player2]

        let dummyTeamDetail = TeamDetail(id: 123, name: "Sample Team", shortName: "ST", tla: "ST", address: "123 Main St", website: "http://www.sampleteam.com", founded: 2000, clubColors: "Blue and White", venue: "Sample Stadium", squad: squad)

        // 適当なダミーデータを生成して返す


        return dummyTeamDetail
    }
}
