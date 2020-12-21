import Foundation
import RealmSwift

class UserArticleProvider: UserArticlesProviderProtocol {

    func getAllStoredArticles() -> [UserArticle] {
        do {
            let realm = try Realm()
            let result =  realm.objects(UserArticle.self)
            return Array(result)
        } catch let error {
            print("error \(error)")
        }
        return []
    }

    func saveArticle(data: UserArticle) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(data)
            }
        } catch let error {
            print("error \(error)")
        }
    }

    func updateArticle(updatedData: UserArticle) {
        // No OP
    }

    func deleteArticle(with id: String) {
        // No OP
    }

    func getArticle(by id: String) -> UserArticle? {
        do {
            let realm = try Realm()
            let result = realm.object(ofType: UserArticle.self, forPrimaryKey: id)
            return result
        } catch let error {
            print("error \(error)")
        }
        return nil
    }

    func seedFakeData() {
        let article = UserArticle()
        article.title = "Article 1"
        article.content = "This is a description"
        self.saveArticle(data: article)

        let article2 = UserArticle()
        article2.title = "Article 2"
        article2.content = "This is another description"
        self.saveArticle(data: article2)
    }
}
