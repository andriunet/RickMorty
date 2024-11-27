//
//  CharacterDetailView.swift
//  RickMorty
//
//  Created by Andres on 26/11/24.
//


import SwiftUI

struct CharacterDetailView: View {
    var character: Character
    @Namespace private var animationNamespace

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
        
                AsyncImageView(url: character.image, id: character.id, namespace: animationNamespace)
                
                VStack(alignment: .leading, spacing: 15) {
                    DetailRowView(title: "Estado", value: character.status)
                    DetailRowView(title: "Especie", value: character.species)
                    DetailRowView(title: "Origen", value: character.origin.name)
                    DetailRowView(title: "Género", value: character.gender)
                    DetailRowView(title: "Creado", value: character.created.formattedDate())
                    DetailRowView(title: "Ubicación actual", value: character.location.name)
                }
                .padding(.horizontal)
                .padding(.top, 5)
            }
            .padding()
        }
        .navigationTitle(character.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AsyncImageView: View {
    let url: String
    let id: Int
    let namespace: Namespace.ID
    
    var body: some View {
        AsyncImage(url: URL(string: url)) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .frame(width: 250, height: 250)
                    .background(Color.gray.opacity(0.2))
                    .clipShape(Circle())
                    .padding()
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250)
                    .clipShape(Circle())
                    .shadow(radius: 10)
                    .matchedGeometryEffect(id: "image\(id)", in: namespace)
                    .padding()
            case .failure:
                Image(systemName: "exclamationmark.triangle.fill")
                    .frame(width: 250, height: 250)
                    .background(Color.gray.opacity(0.2))
                    .clipShape(Circle())
                    .padding()
            @unknown default:
                EmptyView()
            }
        }
        .accessibilityLabel("Imagen del personaje")
        .accessibilityHint("Foto del personaje \(id)")
    }
}

struct DetailRowView: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title + ":")
                .font(.body)
                .fontWeight(.medium)
            Text(value)
                .font(.body)
                .foregroundColor(.secondary)
        }
        .padding(.bottom, 5)
    }
}
