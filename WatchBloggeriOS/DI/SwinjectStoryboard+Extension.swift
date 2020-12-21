import Foundation
import Swinject
import SwinjectStoryboard
import SwinjectAutoregistration

extension SwinjectStoryboard {
    @objc class func setup() {
        // View Controllers
        defaultContainer.storyboardInitCompleted(HomeViewController.self) { resolver, controller in
            controller.viewModel = resolver.resolve(HomeViewModelProtocol.self)
        }

        defaultContainer.storyboardInitCompleted(UserArticlesViewController.self) { resolver, controller in
            controller.viewModel = resolver.resolve(UserArticleViewModelProtocol.self)
            controller.segueHandler = resolver.resolve(SegueHandlerProtocol.self)
        }

        defaultContainer.storyboardInitCompleted(AddEditArticleViewController.self) { resolver, controller in
            controller.viewModel = resolver.resolve(AddEditArticleViewModelProtocol.self)
        }

        // View Models
        defaultContainer.autoregister(HomeViewModelProtocol.self, initializer: HomeViewModel.init)

        defaultContainer.autoregister(AddEditArticleViewModelProtocol.self, initializer: AddEditArticleViewModel.init)

        defaultContainer.autoregister(UserArticleViewModelProtocol.self, initializer: UserArticleViewModel.init)

        // Business logic
        defaultContainer.autoregister(ApiProviderProtocol.self, initializer: ApiProvider.init)

        defaultContainer.autoregister(UserArticlesProviderProtocol.self, initializer: UserArticleProvider.init)

        defaultContainer.autoregister(SegueHandlerProtocol.self, initializer: SegueHandler.init)
    }
}
