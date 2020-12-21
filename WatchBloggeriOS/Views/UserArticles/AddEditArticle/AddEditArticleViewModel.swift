import Foundation

enum ArticleAction {
    case add
    case update
    case delete
}

protocol AddEditArticleViewModelProtocol {
    func configure(viewType: AddEditArticleViewModel.ViewType)
    func performArticleAction(title: String, content: String, action: ArticleAction)
    func getViewTypeConfiguration(
        callback: @escaping (UserArticle?) -> Void
    )
}

class AddEditArticleViewModel: AddEditArticleViewModelProtocol {
    let userArticleProvider: UserArticlesProviderProtocol
    var viewType: ViewType = .ADD

    init(userArticleProvider: UserArticlesProviderProtocol) {
        self.userArticleProvider = userArticleProvider
    }

    func configure(viewType: ViewType) {
        self.viewType = viewType
    }

    func getViewTypeConfiguration(callback: @escaping (UserArticle?) -> Void) {
        switch viewType {
        case .ADD:
            callback(nil)
        case .EDIT(let id):
            let userArticle = userArticleProvider.getArticle(with: id)
            callback(userArticle)
        }
    }

    func performArticleAction(title: String, content: String, action: ArticleAction) {
        switch action {
        case .add:
            let userArticle = UserArticle()
            userArticle.title = title
            userArticle.content = content
            userArticleProvider.saveArticle(data: userArticle)
        case .update:
            if case .EDIT(let id) = viewType,
               let currentArticle = userArticleProvider.getArticle(with: id) {
                let temporalArticle = TemporalArticle()
                temporalArticle.title = title
                temporalArticle.content = content
                userArticleProvider.updateArticle(originalArticle: currentArticle, updatedData: temporalArticle)
            }
        case .delete:
            if case .EDIT(let id) = viewType,
               let existingArticle = userArticleProvider.getArticle(with: id) {
                userArticleProvider.deleteArticle(with: existingArticle)
            }
        }
    }

    enum ViewType {
        case ADD
        case EDIT(id: String)
    }
}
