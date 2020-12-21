import Foundation
import RealmSwift

class UserArticleProvider: UserArticlesProviderProtocol {
    let realm: Realm

    convenience init() {
        // swiftlint:disable:next force_try
        self.init(realm: try! Realm())
    }

    init(realm: Realm) {
        self.realm = realm
      }

    func getAllStoredArticles() -> [UserArticle] {
        return Array(realm.objects(UserArticle.self))
    }

    func saveArticle(data: UserArticle) {
        do {
            try realm.write {
                realm.add(data)
            }
        } catch let error {
            print("error \(error)")
        }
    }

    func updateArticle(originalArticle: UserArticle, updatedData: TemporalArticle) {
        do {
            try realm.write {
                originalArticle.title = updatedData.title
                originalArticle.content = updatedData.content
                originalArticle.image = updatedData.image
            }
        } catch let error {
            print("error \(error)")
        }
    }

    func deleteArticle(with data: UserArticle) {
        do {
            try realm.write {
                realm.delete(data)
            }
        } catch let error {
            print("error \(error)")
        }
    }

    func getArticle(with id: String) -> UserArticle? {
        let result = realm.object(ofType: UserArticle.self, forPrimaryKey: id)
        return result
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
