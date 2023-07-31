//
//  api.swift
//  football
//
//  Created by 遠藤拓弥 on 30.7.2023.
//

import Foundation
import APIKit
import Combine


// APIリクエスト用のクラス
class TeamsAPI {
    // リクエストのエンドポイントURL
    private let baseURL: URL = URL(string: "https://api.football-data.org/v4/")!

    // APIキー（自分のAPIキーを使用してください）
    private let apiKey = ""

    // チーム情報取得APIリクエスト
    func fetchTeams(completion: @escaping ([Team]?) -> Void) {
        let request = TeamsRequest(baseURL: baseURL, apiKey: apiKey)

        Session.send(request) { result in
            switch result {
            case .success(let response):
                completion(response.teams)
            case .failure(let error):
                print("Error fetching teams: \(error)")
                completion(nil)
            }
        }
    }
}

class TeamsAPICombine {
    private let baseURL: URL = URL(string: "https://api.football-data.org/v4/")!

    private let apiKey = ""


    // チーム情報取得APIリクエスト
    func fetchTeams() -> Future<[Team], Error> {
        let request = TeamsRequest(baseURL: baseURL, apiKey: apiKey)

        // Use Combine's Future to handle the API request
        return Future { promise in
            Session.send(request) { result in
                switch result {
                case .success(let response):
                    promise(.success(response.teams))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
    }
}



class TeamsAPIAsync {
    private let baseURL: URL = URL(string: "https://api.football-data.org/v4/")!
    private let apiKey = ""


    // APIError enum to handle errors
    enum APIError: Error {
        case networkError(Error)
        case decodingError(Error)
    }

    // チーム情報取得APIリクエスト
    func fetchTeams() async throws -> [Team] {
        let request = TeamsRequest(baseURL: baseURL, apiKey: apiKey)

        do {
            let response = try await sendRequest(request)
            return response.teams
        } catch {
            throw APIError.networkError(error)
        }
    }

    private func sendRequest<T: Request>(_ request: T) async throws -> T.Response {
        do {
            return try await withCheckedThrowingContinuation { continuation in
                Session.send(request) { result in
                    switch result {
                    case .success(let response):
                        continuation.resume(returning: response)
                    case .failure(let error):
                        continuation.resume(throwing: APIError.networkError(error))
                    }
                }
            }
        } catch {
            throw APIError.decodingError(error)
        }
    }
}

// APIリクエストの定義
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
struct Team: Decodable {
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
