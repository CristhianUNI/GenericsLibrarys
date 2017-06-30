#
# Be sure to run `pod lib lint LibraryGeneric.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'LibraryGeneric'
  s.version          = '0.2.1'
  s.summary          = 'Generics Librarys for iOS Apps'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Generics Librarys for iOS Apps in Core Systems
                       DESC

  s.homepage         = 'https://github.com/CristhianUNI/GenericsLibrarys'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'cristhian' => 'cristhian.aguirre@cocomsys.com' }
  s.source           = { :git => 'https://github.com/CristhianUNI/GenericsLibrarys.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'LibraryGeneric/LibraryGeneric/Classes/*.swift', 'LibraryGeneric/LibraryGeneric/Classes/Extension/*.swift', 'LibraryGeneric/LibraryGeneric/Classes/TableView/*.swift', 'LibraryGeneric/LibraryGeneric/Classes/NetWorking/Base/*.swift', 'LibraryGeneric/LibraryGeneric/Classes/NetWorking/Parsers/*.swift'
  
  # s.resource_bundles = {
  #   'LibraryGeneric' => ['LibraryGeneric/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
    s.frameworks = 'UIKit', 'Foundation'
    s.dependency 'SwiftyJSON'
    s.dependency 'Kingfisher', '~> 3.0'
    s.dependency 'Alamofire', '~> 4.0'
    s.dependency 'PromiseKit', '~> 4.0'
    s.dependency 'ResponseDetective'
end
