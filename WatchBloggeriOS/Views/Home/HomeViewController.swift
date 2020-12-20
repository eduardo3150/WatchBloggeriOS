import UIKit
import Combine

class HomeViewController: UIViewController {
    var viewModel: HomeViewModelProtocol?

    var cancellables: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel?.getWatchArticles()

        viewModel?
            .articlesPublished
            .sink(receiveValue: { [weak self] _ in
            }).store(in: &cancellables)
    }
}
