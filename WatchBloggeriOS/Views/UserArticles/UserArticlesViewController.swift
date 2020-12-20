import Foundation
import UIKit

class UserArticlesViewController: UIViewController {
    @IBOutlet weak var userArticlesTableView: UITableView!

    var viewModel: UserArticleViewModelProtocol?

    let articlesTableManager = UserArticleTableManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        userArticlesTableView.delegate = articlesTableManager
        userArticlesTableView.dataSource = articlesTableManager

        articlesTableManager.setUserArticlesData(articles: viewModel!.getAllStoredArticles())
    }
}
