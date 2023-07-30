//
//  TeamsInteractorCombine.swift
//  football
//
//  Created by 遠藤拓弥 on 30.7.2023.
//

import Combine
import Foundation


protocol TeamsInteractorCombineInput {
    func fetchTeams() -> AnyPublisher<[Team], Error>
}

class TeamsInteractorCombine: TeamsInteractorCombineInput {
    private let teamsAPI = TeamsAPICombine()

    func fetchTeams() -> AnyPublisher<[Team], Error> {
        // Use the Combine Future to handle asynchronous fetchTeams call
        return teamsAPI.fetchTeams().eraseToAnyPublisher() 
    }
}
