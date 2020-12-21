import Foundation

protocol UserArticlesProviderProtocol {
    func getAllStoredArticles() -> [UserArticle]
    func saveArticle(data: UserArticle)
    func updateArticle(originalArticle: UserArticle, updatedData: TemporalArticle)
    func deleteArticle(with data: UserArticle)
    func getArticle(with id: String) -> UserArticle?
    func seedFakeData()
}
