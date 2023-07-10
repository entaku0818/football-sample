//
//  footballApp.swift
//  football
//
//  Created by 遠藤拓弥 on 10.7.2023.
//

import SwiftUI

@main
struct footballApp: App {
    var body: some Scene {
        WindowGroup {
            TeamsView(presenter: TeamsPresenter(interactor: TeamsInteractor()))
        }
    }
}
