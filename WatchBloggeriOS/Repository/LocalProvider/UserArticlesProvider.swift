import Foundation
import RealmSwift

class UserArticleProvider: UserArticlesProviderProtocol {

    func getAllStoredArticles() -> [UserArticle] {
        do {
            // Get the default Realm
            let realm = try Realm()
            // You only need to do this once (per thread)
            let result =  realm.objects(UserArticle.self)
            return Array(result)
        } catch let error {
            print("error \(error)")
        }
        return []
    }

    func saveArticle(data: UserArticle) {
        do {
            // Get the default Realm
            let realm = try Realm()
            // You only need to do this once (per thread)
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

    func getArticle(by id: String) -> UserArticle {
        do {
            // Get the default Realm
            let realm = try Realm()
            // You only need to do this once (per thread)
            let result =  realm.objects(UserArticle.self).filter("id = \(id)")
//            let result2 = realm.object(ofType: UserArticle.self, forPrimaryKey: id)
            return result.first!
        } catch let error {
            print("error \(error)")
        }
        return UserArticle()
    }

    func seedFakeData() {
        let article = UserArticle()
        article.id = 0
        article.title = "Article 1"
        article.content = "This is a description"
        self.saveArticle(data: article)

        let article2 = UserArticle()
        article2.id = 1
        article2.title = "Article 2"
        article2.content = "This is another description"
        self.saveArticle(data: article2)
    }
}
