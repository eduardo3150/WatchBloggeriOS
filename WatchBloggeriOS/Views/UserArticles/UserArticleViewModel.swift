import Foundation

protocol UserArticleViewModelProtocol {
    func getAllStoredArticles() -> [UserArticle]
}

class UserArticleViewModel: UserArticleViewModelProtocol {
    let userArticleProvider: UserArticlesProviderProtocol

    init(userArticleProvider: UserArticlesProviderProtocol) {
        self.userArticleProvider = userArticleProvider
        print("first article \(userArticleProvider.getArticle(by: "0"))")
    }

    func getAllStoredArticles() -> [UserArticle] {
        return userArticleProvider.getAllStoredArticles()
    }
}
