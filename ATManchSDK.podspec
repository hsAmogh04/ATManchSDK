#
# Be sure to run `pod lib lint ATManchSDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ATManchSDK'
  s.version          = '0.1.4'
  s.summary          = 'A short description of ATManchSDK.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Manch SDK for eSIgn.
                       DESC

  s.homepage         = 'https://github.com/hsamogh04/ATManchSDK'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Atmaram' => 'atmaram.thakur@gmail.com' }
  s.source           = { :git => 'https://github.com/hsAmogh04/ATManchSDK.git', :tag => s.version.to_s }
  
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10'

  s.source_files = 'ATManchSDK/Classes/**/*'
  # s.resource_bundles = {
  #   'ATManchSDK' => ['ATManchSDK/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
