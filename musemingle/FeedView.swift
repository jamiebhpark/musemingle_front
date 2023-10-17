import SwiftUI

struct FeedView: View {
    var posts: [FeedPost] = FeedPost.example
    
    @State private var likedPosts: [String: Bool] = [:]
    @State private var bookmarkedPosts: [String: Bool] = [:]

    var body: some View {
        VStack {
            List(posts, id: \.postImageName) { post in
                VStack(alignment: .leading, spacing: 15) {
                    HStack {
                        Circle()
                            .fill(Color.gray)
                            .frame(width: 30, height: 30)
                        Text(post.username)
                            .font(.headline)
                        Spacer()
                    }
                    
                    NavigationLink(destination: DescriptionView(artwork: ArtworkDetail(from: post), otherWorks: [])) {
                        Image(post.postImageName)
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity, maxHeight: 400)
                            .clipped()
                    }
                    .buttonStyle(PlainButtonStyle()) // Ensure it behaves only as a link

                    HStack {
                        Text("Image Title")
                            .font(.headline)
                        Spacer()
                        Button(action: {
                            likedPosts[post.postImageName, default: false].toggle()
                        }) {
                            Image(systemName: likedPosts[post.postImageName, default: false] ? "heart.fill" : "heart")
                        }
                        .foregroundColor(likedPosts[post.postImageName, default: false] ? .red : .gray)
                        
                        Button(action: {
                            bookmarkedPosts[post.postImageName, default: false].toggle()
                        }) {
                            Image(systemName: bookmarkedPosts[post.postImageName, default: false] ? "bookmark.fill" : "bookmark")
                        }
                        .foregroundColor(bookmarkedPosts[post.postImageName, default: false] ? .blue : .gray)
                    }
                    .font(.title2)
                    .buttonStyle(PlainButtonStyle()) // This ensures the button doesn't have default button styling
                    
                    Text("Image Subtitle")
                        .font(.subheadline)
                        .opacity(0.7)
                    
                    if let description = post.description {
                        Text(description)
                            .font(.subheadline)
                            .padding(.top, 5)
                    }
                    
                    Text(post.timestamp)
                        .font(.footnote)
                        .opacity(0.6)
                        .padding(.top, 5)
                }
                .padding(.vertical, 10)
            }
        }
        .background(Color.white)
        .navigationBarTitle("FEED", displayMode: .inline)
    }
}



struct FeedPost {
    var username: String
    var location: String?
    var postImageName: String
    var description: String?
    var timestamp: String
    var isLiked: Bool = false // New property
    var isBookmarked: Bool = false // New property
}


extension FeedPost {
    // Sample data
    static let example = [
        FeedPost(username: "user1", location: "Location 1", postImageName: "sampleImage1", description: "This is a description.", timestamp: "2 hours ago"),
        FeedPost(username: "user2", location: nil, postImageName: "sampleImage2", description: "Another description.", timestamp: "5 hours ago"),
    ]
}
extension ArtworkDetail {
    init(from feedPost: FeedPost) {
        self.imageName = feedPost.postImageName
        self.title = feedPost.username // You might want to change this according to your needs
        self.subtitle = feedPost.description
        self.artistName = feedPost.username // Assuming the username is the artist's name
        self.year = "" // Placeholder, adjust accordingly
        self.method = "" // Placeholder, adjust accordingly
        self.description = feedPost.description ?? ""
    }
}
