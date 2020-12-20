import Foundation

protocol UserArticlesProviderProtocol {
    func getAllStoredArticles() -> [UserArticle]
    func saveArticle(data: UserArticle)
    func updateArticle(updatedData: UserArticle)
    func deleteArticle(with id: String)
    func getArticle(by id: String) -> UserArticle
}

struct UserArticle {
    let title: String
    let content: String
    let image: String?
}
