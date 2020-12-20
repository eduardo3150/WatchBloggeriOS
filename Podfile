# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'WatchBloggeriOS' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  pod 'SwiftLint'
  pod 'Swinject'
  pod 'SwinjectStoryboard', :git => 'https://github.com/Swinject/SwinjectStoryboard.git', :branch => 'master', :inhibit_warnings => true
  pod 'SwinjectAutoregistration', '2.7.0'
  pod 'Alamofire', '~> 5.2'

  # Pods for WatchBloggeriOS

  target 'WatchBloggeriOSTests' do
    inherit! :search_paths
    pod 'Swinject'
    pod 'SwinjectAutoregistration'
    pod 'Quick'
    pod 'Nimble'
    pod 'Spry', :git => 'https://github.com/NikSativa/Spry.git', :branch => 'master', :inhibit_warnings => true
    pod 'Spry+Nimble'
  end

end
