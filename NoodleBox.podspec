#
# Be sure to run `pod lib lint NoodleBox.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'NoodleBox'
  s.version          = '0.1.5'
  s.summary          = 'Swift library with convenience extensions and custom data structures.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, NoodleNation strips it!

  s.description      = <<-DESC
Swift library with convenience extensions and custom data structures to save developer headaches.
                       DESC

  s.homepage         = 'https://github.com/NoodleOfDeath/NoodleBox'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'NoodleOfDeath' => 'noodlebox@noodlenation.net' }
  s.source           = { :git => 'https://github.com/NoodleOfDeath/NoodleBox.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/Noodle_of_Death'

  s.ios.deployment_target = '8.0'

  s.source_files = 'NoodleBox/**/*'
  
  # s.resource_bundles = {
  #   'NoodleBox' => ['NoodleBox/Assets/*.png']
  # }

  # /// .public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '* 2.3'
end
