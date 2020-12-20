import Foundation

struct WatchArticleResponse: Decodable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

struct Article: Decodable {
    let author: String?
    let title: String
    let description: String?
    let url: String?
    let urlToImage: String?
}
