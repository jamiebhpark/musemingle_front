import SwiftUI

struct ProfileView: View {
    var artistProfile: ArtistProfile

    @State private var showPortfolio = false
    @State private var showArtistInfo = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                HStack {
                    Text(artistProfile.name)
                        .font(.system(size: 18))
                        .bold()
                        .onTapGesture {
                            showArtistInfo = true
                        }
                        .padding(.leading, 15)
                    
                    if artistProfile.isVerified {
                        Image(systemName: "checkmark.seal.fill")
                            .foregroundColor(.blue)
                            .imageScale(.medium)
                            .padding(.leading, 5)
                    }
                    
                    Spacer()

                    NavigationLink(destination: PortfolioView(userID: artistProfile.userID), isActive: $showPortfolio) {
                        Text("More Works")
                    }
                    .onTapGesture {
                        showPortfolio = true
                    }
                    .font(.system(size: 15))
                    .foregroundColor(Color.blue)
                    .padding(.horizontal)
                }
                .sheet(isPresented: $showArtistInfo) {
                    ArtistInfoView(artist: artistProfile)
                }

                Text(artistProfile.field)
                    .font(.system(size: 15))
                    .foregroundColor(.gray)
                    .padding(.horizontal)

                HStack(spacing: 10) {
                    Button(action: {
                    }) {
                        HStack {
                            Image(systemName: "person.fill")
                                .foregroundColor(Color.blue)
                            Text("Follow")
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.blue, lineWidth: 1)
                        )
                    }

                    Button(action: {
                    }) {
                        HStack {
                            Image(systemName: "envelope.fill")
                                .foregroundColor(Color.blue)
                            Text("Contact")
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.blue, lineWidth: 1)
                        )
                    }
                }
                .font(.system(size: 14))
                .padding(.horizontal)

                Group {
                    Text("Major Work")
                        .font(.headline)
                        .padding(.horizontal)

                    NavigationLink(destination: DescriptionView(artwork: ArtworkDetail(imageName: artistProfile.majorWork.imageName, title: artistProfile.majorWork.title, subtitle: nil, artistName: artistProfile.majorWork.artistName, year: "2023", method: "Unknown", description: "Description needed"), otherWorks: artistProfile.otherWorks)) {
                        Image(artistProfile.majorWork.imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                            .padding(.horizontal)
                    }

                    Text("Other Works")
                        .font(.headline)
                        .padding(.horizontal)

                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                        ForEach(artistProfile.otherWorks, id: \.id) { artwork in
                            NavigationLink(destination: DescriptionView(artwork: ArtworkDetail(imageName: artwork.imageName, title: artwork.title, subtitle: nil, artistName: artwork.artistName, year: "2023", method: "Unknown", description: "Description needed"), otherWorks: artistProfile.otherWorks)) {
                                Image(artwork.imageName)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 150)
                                    .cornerRadius(8)
                                    .shadow(radius: 5)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
}

struct ArtistInfoView: View {
    var artist: ArtistProfile

    var body: some View {
        VStack(spacing: 20) {
            Text(artist.name)
                .font(.largeTitle)
                .bold()

            Text("작가 소개")
                .font(.headline)

            Text("이곳에 작가의 소개를 넣어주세요.")
                .multilineTextAlignment(.leading)

            Text("작가 업적")
                .font(.headline)

            Text("이곳에 작가의 업적을 나열해주세요.")
                .multilineTextAlignment(.leading)

            Spacer()
        }
        .padding()
    }
}

struct ArtistProfile {
    var name: String
    var isVerified: Bool
    var field: String
    var majorWork: Artwork
    var otherWorks: [Artwork]
    var userID: String
}
