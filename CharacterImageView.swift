import SwiftUI

struct CharacterImageView: View {
    let imageUrl: String

    var body: some View {
        AsyncImage(url: URL(string: imageUrl)) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .frame(width: 50, height: 50)
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
            case .failure:
                Image(systemName: "exclamationmark.triangle.fill")
                    .frame(width: 50, height: 50)
            @unknown default:
                EmptyView()
            }
        }
    }
}