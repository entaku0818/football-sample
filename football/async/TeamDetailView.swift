//
//  TeamDetailView.swift
//  football
//
//  Created by 遠藤拓弥 on 3.9.2023.
//
import SwiftUI
import Foundation

struct TeamDetailView: View {
    var team: Team

    var body: some View {
        VStack(alignment: .leading) {
            if let imageUrl = URL(string: team.crest) {
                 AsyncImage(url: imageUrl) { image in
                     image.resizable()
                         .aspectRatio(contentMode: .fit)
                 } placeholder: {
                     ProgressView()
                 }
                 .frame(maxHeight: 150)
             }

            Text("Team Detail: \(team.name)")
                .font(.headline)
            Text("Short Name: \(team.shortName)")
                .font(.subheadline)
            Text("TLA: \(team.tla)")
                .font(.subheadline)
            Text("Founded: \(team.founded ?? 0)")
                .font(.subheadline)
            // Display other properties as needed
        }
        .padding()
    }
}
