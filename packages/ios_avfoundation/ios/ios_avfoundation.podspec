require 'yaml'

pubspec = YAML.load_file(File.join('..', 'pubspec.yaml'))
library_version = pubspec['version'].gsub('+', '-')

Pod::Spec.new do |s|
  s.name             = pubspec['name']
  s.version          = library_version
  s.summary          = 'Ios platform implementation of the ios_avfoundation plugin.'
  s.description      = pubspec['description']
  s.homepage         = pubspec['homepage']
  s.license          = { :type => 'MIT', :file => '../LICENSE' }
  s.author           = pubspec['author']
  s.source           = { :http => 'https://github.com/bparrishMines/penguin/tree/master/packages/ios_avfoundation' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.dependency 'reference'
  s.platform = :ios, '8.0'

  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'VALID_ARCHS' => 'armv7 arm64 x86_64' }

  # s.test_spec 'Tests' do |test_spec|
    # test_spec.source_files = 'Tests/**/*'
    # test_spec.dependency 'OCHamcrest', '~> 7.1.2'
  # end
end
