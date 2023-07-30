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
            MenuView()
        }
    }
}


struct MenuView: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: TeamsView(presenter: TeamsPresenter(interactor: TeamsInteractor()))) {
                    Text("TeamsView")
                }
                NavigationLink(destination: TeamsViewCombine(presenter: TeamsPresenterCombine(interactor: TeamsInteractorCombine()))) {
                    Text("TeamsViewCombine")
                }
            }
            .navigationTitle("Menu")
        }
    }
}
