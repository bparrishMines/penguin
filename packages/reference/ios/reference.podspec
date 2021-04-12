require 'yaml'

pubspec = YAML.load_file(File.join('..', 'pubspec.yaml'))
library_version = pubspec['version'].gsub('+', '-')

Pod::Spec.new do |s|
  s.name             = pubspec['name']
  s.version          = library_version
  s.summary          = 'A Flutter plugin library for communicating language types.'
  s.description      = pubspec['description']
  s.homepage         = 'https://github.com/bparrishMines/penguin/tree/master/packages/reference'
  s.license          = { :type => 'MIT', :file => '../LICENSE' }
  s.author           = { 'Brandon Parrish' => 'bparr2450@gmail.com' }
  s.source           = { :http => 'https://github.com/bparrishMines/penguin/tree/master/packages/reference' }
  s.documentation_url = 'https://pub.dev/documentation/reference/latest'
  s.source_files = [
    'Classes/**/*',
    # Since we can't embed source from ../third_party/, we have created files
    # in ios/third_party/... which simply use #include "../...". This is a hack!
    #'third_party/dart-sdk/**/*.{c,h}',
  ]
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.platform = :ios, '8.0'

  s.pod_target_xcconfig = {
    #'HEADER_SEARCH_PATHS' => [
    #  '$(PODS_TARGET_SRCROOT)/../third_party/dart-sdk/src/runtime',
    #],
    'DEFINES_MODULE' => 'YES',
    'VALID_ARCHS' => 'armv7 arm64 x86_64'
  }

  s.test_spec 'Tests' do |test_spec|
    test_spec.source_files = 'Tests/**/*'
    test_spec.dependency 'OCHamcrest', '~> 7.1.2'
  end
end
