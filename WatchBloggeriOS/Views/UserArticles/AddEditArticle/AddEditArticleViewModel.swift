import Foundation

protocol AddEditArticleViewModelProtocol {
    func configure(viewType: AddEditArticleViewModel.ViewType)
}

class AddEditArticleViewModel: AddEditArticleViewModelProtocol {
    let userArticleProvider: UserArticlesProviderProtocol

    init(userArticleProvider: UserArticlesProviderProtocol) {
        self.userArticleProvider = userArticleProvider
    }

    func configure(viewType: ViewType) {
        switch viewType {
        case .ADD:
            print("add new")
        case .EDIT(let id):
            let article = userArticleProvider.getArticle(by: id)
            print("view \(article)")
        }
    }

    enum ViewType {
        case ADD
        case EDIT(id: String)
    }
}
