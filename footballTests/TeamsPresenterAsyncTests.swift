//
//  TeamsPresenterAsyncTests.swift
//  footballTests
//
//  Created by 遠藤拓弥 on 27.8.2023.
//

import XCTest
@testable import football

class TeamsPresenterAsyncTests: XCTestCase {

    var presenter: TeamsPresenterAsync!

    override func setUpWithError() throws {
        let mockInteractor = MockTeamsAPIAsync()

        presenter = TeamsPresenterAsync(interactor: mockInteractor)
    }

    override func tearDownWithError() throws {
        presenter = nil 
    }

    func testUpdateView() async throws {
        try await presenter.updateView()
        XCTAssertEqual(presenter.teams.count, 2)
    }

    func testPerformanceExample() throws {
        self.measure {
        }
    }
}
