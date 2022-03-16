#
# Be sure to run `pod lib lint A4xWebRtcFramework.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'A4xWebRtcFramework'
  s.version          = '0.1.0'
  s.summary          = 'A short description of A4xWebRtcFramework.'


  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/A4xWebRtcFramework/A4xWebRtcFramework'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'A4xWebRtcFramework' => 'wjin@a4x.ai' }
  s.source           = { :git => 'http://192.168.31.7:7990/scm/swclien/webrtc-ios-demo.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'


  s.source_files = 'A4xWebRtcFramework/*.{swift,h,m,mm}'
  s.public_header_files = 'A4xWebRtcFramework/A4xWebRtcGenerateImage.h'
  #二级目录
  s.subspec 'FFmpeg' do |ffmpeg|
    ffmpeg.source_files = 'A4xWebRtcFramework/FFmpeg/*.{swift,h,m,mm}'
  end
  #二级目录
  s.vendored_frameworks    =  'Frameworks/*.framework'
  s.xcconfig     = {
    'ENABLE_BITCODE' => 'NO'
  }
 
  s.dependency 'Starscream'
  s.frameworks = 'VideoToolBox'
  s.libraries =  'iconv', 'z'
  s.dependency 'XCGLogger', '~> 7.0.1'
  s.dependency 'YYWebImage', '~>1.0.5'
end
