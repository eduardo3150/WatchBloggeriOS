import Foundation
import Swinject
import SwinjectStoryboard
import SwinjectAutoregistration

extension SwinjectStoryboard {
    @objc class func setup() {
        defaultContainer.storyboardInitCompleted(HomeViewController.self) { resolver, completed in
            completed.viewModel = resolver.resolve(HomeViewModelProtocol.self)
        }
        defaultContainer.autoregister(HomeViewModelProtocol.self, initializer: HomeViewModel.init)

        defaultContainer.autoregister(ApiProviderProtocol.self, initializer: ApiProvider.init)

        defaultContainer.storyboardInitCompleted(UserArticlesViewController.self) { resolver, completed in
            completed.viewModel = resolver.resolve(UserArticleViewModelProtocol.self)
        }
        defaultContainer.autoregister(UserArticleViewModelProtocol.self, initializer: UserArticleViewModel.init)

        defaultContainer.autoregister(UserArticlesProviderProtocol.self, initializer: UserArticleProvider.init)
    }
}
