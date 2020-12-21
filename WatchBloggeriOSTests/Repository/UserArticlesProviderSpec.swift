import Foundation
import Quick
import Nimble
import RealmSwift

@testable import WatchBloggeriOS

class UserArticlesProviderSpec: QuickSpec {
  override func spec() {
    describe("UserArticlesProvider") {
      var testRealm: Realm!
      var subject: UserArticlesProviderProtocol!

        beforeEach {
            // swiftlint:disable:next force_try
            testRealm = try! Realm(configuration: Realm.Configuration(inMemoryIdentifier: "pizza-controller-spec"))
            subject = UserArticleProvider(realm: testRealm)
        }

        afterEach {
            do {
                try testRealm.write {
                    testRealm.deleteAll()
                }
            } catch let error {
                print(error)
            }
        }

        it("adds User article to Realm") {
            expect(subject.getAllStoredArticles().count).to(equal(0))

            let article = UserArticle()
            article.title = "Article 1"
            article.content = "This is a description"
            subject.saveArticle(data: article)
            expect(subject.getAllStoredArticles().count).to(equal(1))
        }

        it("updates User article to Realm") {
            expect(subject.getAllStoredArticles().count).to(equal(0))

            let originalArticle = UserArticle()
            originalArticle.title = "Article 1"
            originalArticle.content = "This is a description"

            subject.saveArticle(data: originalArticle)
            let storedArticles = subject.getAllStoredArticles()

            expect(storedArticles.count).to(equal(1))

            let articleToUpdate = subject.getArticle(with: storedArticles[0].id)

            expect(articleToUpdate!.content).to(equal(originalArticle.content))

            let temporalData = TemporalArticle()
            temporalData.content = "This is an updated content"

            subject.updateArticle(originalArticle: articleToUpdate!, updatedData: temporalData)

            let storedUpdatedArticles = subject.getAllStoredArticles()

            expect(storedUpdatedArticles.count).to(equal(1))

            expect(storedUpdatedArticles[0].content).to(equal(temporalData.content))
        }

        it("deletes User article from Realm") {
            expect(subject.getAllStoredArticles().count).to(equal(0))

            let article = UserArticle()
            article.title = "Article Test"
            article.content = "This is a description"
            subject.saveArticle(data: article)
            let storedArticles = subject.getAllStoredArticles()
            expect(storedArticles.count).to(equal(1))

            subject.deleteArticle(with: storedArticles[0])
            let deletedArticles = subject.getAllStoredArticles()
            expect(deletedArticles.count).to(equal(0))
        }
    }
  }
}
