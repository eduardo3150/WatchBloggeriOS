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
    }
}
