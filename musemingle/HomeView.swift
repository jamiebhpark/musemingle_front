import SwiftUI

struct HomeView: View {
    var top50Artworks: [Artwork] = [Artwork(imageName: "sampleImage1", title: "Paralyzed",artistName: "Jamie")]
    var newArtworks: [Artwork] = [Artwork(imageName: "sampleImage3", title: "Slient", artistName: "Ben"), Artwork(imageName: "sampleImage4", title: "Alone", artistName: "Ben")]
    var exhibitions: [Exhibition] = [Exhibition(imageName: "sampleImage2", name: "GR2023", galleryName: "SEOULTECH")]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading){
                LazyVStack(alignment: .leading, spacing: 20) {
                    SectionView(title: "Archive: Top 50", items: top50Artworks, otherWorks: newArtworks)
                    SectionView(title: "Archive: New", items: newArtworks, otherWorks: newArtworks)
                    ExhibitionSectionView(title: "Exhibitions", items: exhibitions)
                }
            }
            .padding(.horizontal)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarTitle("HOME", displayMode: .inline)

            }
        }
    }
struct SectionView: View {
    let title: String
    let items: [Artwork]
    let otherWorks: [Artwork] // 추가

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title3)
                .bold()
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 15) {
                    ForEach(items) { item in
                        ArtworkView(artwork: item, otherWorks: otherWorks)
                    }
                }
            }
        }
    }
}
struct ExhibitionSectionView: View {
    let title: String
    let items: [Exhibition]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title3)
                .bold()
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 15) {
                    ForEach(items) { item in
                        ExhibitionView(exhibition: item)
                    }
                }
            }
        }
    }
}

struct ArtworkView: View {
    var artwork: Artwork
    var otherWorks: [Artwork]

    
    var body: some View {
        NavigationLink(destination: DescriptionView(artwork: ArtworkDetail(imageName: artwork.imageName, title: artwork.title, subtitle: nil, artistName: artwork.artistName, year: "2023", method: "Photo, iPhone15ProMAX", description: "A beautiful depiction of ..."), otherWorks: otherWorks)) {
             
            VStack(alignment: .leading) {
                Image(artwork.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 120, height: 120)
                    .clipped()
                    .cornerRadius(8)
                    .shadow(radius: 5)
                Text(artwork.title)
                    .font(.headline)
                    .padding(.top, 2)
                    .foregroundStyle(.black)
                Text(artwork.artistName)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
    }
}
    
    struct ExhibitionView: View {
        var exhibition: Exhibition
        
        var body: some View {
                VStack(alignment: .leading) {
                    Image(exhibition.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 120, height: 120)
                        .clipped()
                        .cornerRadius(8)
                        .shadow(radius: 5)
                    Text(exhibition.name)
                        .font(.headline)
                        .padding(.top, 2)
                    Text(exhibition.galleryName)
                        .font(.subheadline)
                    .foregroundColor(.gray)        }
            }
        }
        
        struct Artwork: Identifiable {
            var id: UUID = UUID()
            var imageName: String
            var title: String
            var artistName: String
        }
        
struct Exhibition: Identifiable {
    var id: UUID = UUID()
    var imageName: String
    var name: String
    var galleryName: String
}
