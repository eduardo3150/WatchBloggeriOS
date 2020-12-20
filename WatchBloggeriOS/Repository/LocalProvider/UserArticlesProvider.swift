import Foundation

class UserArticleProvider: UserArticlesProviderProtocol {
    let articles = [UserArticle(title: "One", content: "Hi", image: nil)]

    func getAllStoredArticles() -> [UserArticle] {
        return articles
    }

    func saveArticle(data: UserArticle) {
        // No OP
    }

    func updateArticle(updatedData: UserArticle) {
        // No OP
    }

    func deleteArticle(with id: String) {
        // No OP
    }

    func getArticle(by id: String) -> UserArticle {
        return articles[0]
    }
}
