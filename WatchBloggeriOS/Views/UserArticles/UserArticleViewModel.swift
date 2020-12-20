import Foundation

protocol UserArticleViewModelProtocol {
    func getAllStoredArticles() -> [UserArticle]
}

class UserArticleViewModel: UserArticleViewModelProtocol {
    let userArticleProvider: UserArticlesProviderProtocol

    init(userArticleProvider: UserArticlesProviderProtocol) {
        self.userArticleProvider = userArticleProvider
    }

    func getAllStoredArticles() -> [UserArticle] {
        return userArticleProvider.getAllStoredArticles()
    }
}
