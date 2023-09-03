//
//  Request.swift
//  football
//
//  Created by 遠藤拓弥 on 3.9.2023.
//

import Foundation
import APIKit
struct TeamsRequest: Request {

    var baseURL: URL

    typealias Response = TeamsData

    let apiKey: String

    var path: String {
        return "competitions/PL/teams/"
    }

    var method: HTTPMethod {
        return .get
    }

    var headerFields: [String: String] {
        return ["X-Auth-Token": apiKey]
    }

    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        guard let data = try? JSONSerialization.data(withJSONObject: object),
              let teamsData = try? JSONDecoder().decode(TeamsData.self, from: data) else {
            throw ResponseError.unexpectedObject(object)
        }
        return teamsData
    }

}

struct TeamDetailRequest: Request {

    var baseURL: URL

    typealias Response = TeamDetail

    var teamId:Int

    let apiKey: String

    var path: String {
        return "/teams/\(teamId)"
    }

    var method: HTTPMethod {
        return .get
    }

    var headerFields: [String: String] {
        return ["X-Auth-Token": apiKey]
    }

    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        guard let data = try? JSONSerialization.data(withJSONObject: object),
              let teamData = try? JSONDecoder().decode(TeamDetail.self, from: data) else {
            throw ResponseError.unexpectedObject(object)
        }
        return teamData
    }

}
