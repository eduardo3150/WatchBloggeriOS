import UIKit
import Combine

class HomeViewController: UIViewController {
    @IBOutlet weak var articlesTableView: UITableView!

    var viewModel: HomeViewModelProtocol?
    var cancellables: Set<AnyCancellable> = []
    let articlesDataSource = ArticlesDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        articlesTableView.delegate = articlesDataSource
        articlesTableView.dataSource = articlesDataSource

        viewModel?.getWatchArticles()

        viewModel?
            .articlesPublished
            .sink(receiveValue: { [weak self] articleMain in
                self?.articlesDataSource.setArticlesData(articles: articleMain.articles)
                self?.articlesTableView.reloadData()
            }).store(in: &cancellables)
    }
}
