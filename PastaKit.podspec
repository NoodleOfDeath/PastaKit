#
# Be sure to run `pod lib lint PastaKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'PastaKit'
  s.version          = '0.1.9'
  s.summary          = 'Swift library with convenience extensions and custom data structures.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, NoodleNation strips it!

  s.description      = <<-DESC
Swift library with convenience extensions and custom data structures to save developer headaches.
                       DESC

  s.homepage         = 'https://github.com/NoodleOfDeath/PastaKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'NoodleOfDeath' => 'pastakit@noodlenation.net' }
  s.source           = { :git => 'https://github.com/NoodleOfDeath/PastaKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/Noodle_of_Death'

  s.ios.deployment_target = '8.0'

  s.source_files = 'PastaKit/**/*'

end
