#
# Be sure to run `pod lib lint IDKitSignature.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'IDKitSignature'
  s.version          = '0.1.0'
  s.summary          = '用于项目中需要采集用户的签名的功能'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
                        该库是用于项目中需要采集用户的签名。该库包含单独的签名功能以及UI,可自定义UI的等功能。
                       DESC

  s.homepage         = 'https://github.com/zhoushuangjian511@163.com/IDKitSignature'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'zhoushuangjian511@163.com' => 'zhoushuangjian@algnto.com' }
  s.source           = { :git => 'https://github.com/zhoushuangjian001/IDKitSignature.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'IDKitSignature/Classes/**/*'
  s.swift_version = '5.0'
  # s.resource_bundles = {
  #   'IDKitSignature' => ['IDKitSignature/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
