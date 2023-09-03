//
//  TeamsPresenterAsyncTests.swift
//  footballTests
//
//  Created by 遠藤拓弥 on 27.8.2023.
//
import XCTest
@testable import football

class TeamDetailPresenterAsyncTests: XCTestCase {

    var presenter: TeamDetailPresenterAsync!
    let mockTeamId = 123  // モックのチームID

    override func setUpWithError() throws {
        let mockInteractor = MockTeamDetailAPIAsync()

        presenter = TeamDetailPresenterAsync(interactor: mockInteractor, teamId: mockTeamId)
    }

    override func tearDownWithError() throws {
        presenter = nil
    }

    func testUpdateView() async throws {
        // モックのデータを設定（適切なデータを用意してください）

        try await presenter.updateView()
        XCTAssertNotNil(presenter.team)
        XCTAssertEqual(presenter.team?.squad.count, 2)

        // プレゼンターのプロパティが正しく更新されているかを検証
    }

    // 他にも必要なテストメソッドを追加することができます

}
