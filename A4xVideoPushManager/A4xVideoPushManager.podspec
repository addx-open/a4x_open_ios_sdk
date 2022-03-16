#
# Be sure to run `pod lib lint A4xVideoPushManager.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'A4xVideoPushManager'
  s.version          = '1.0.0'
  s.summary          = 'A short description of A4xVideoPushManager.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/Kuiyu Zhi/A4xVideoPushManager'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Kuiyu Zhi' => 'kzhi@addx.ai' }
  s.source           = { :git => 'https://github.com/Kuiyu Zhi/A4xVideoPushManager.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.swift_version = '4.2'
  #二级目录
  s.subspec 'Classes' do |ss|
    ss.source_files = 'A4xVideoPushManager/Classes/**/*'
  end
  
    #二级目录
  s.subspec 'Resources' do |ss|
      ss.resource_bundles = {
     'A4xVideoPushManager' => ['A4xVideoPushManager/Assets/*.png']
  }
  end
  

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'AutoInch', '~> 1.3.1'
  s.dependency 'YYWebImage', '~>1.0.5'

end
