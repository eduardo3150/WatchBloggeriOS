import Foundation
import UIKit

class AddEditArticleViewController: UIViewController {
    var viewModel: AddEditArticleViewModelProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func configureView(with viewType: AddEditArticleViewModel.ViewType) {
        viewModel?.configure(viewType: viewType)
    }
}
