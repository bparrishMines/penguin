require 'yaml'

pubspec = YAML.load_file(File.join('..', 'pubspec.yaml'))
library_version = pubspec['version'].gsub('+', '-')

Pod::Spec.new do |s|
  s.name             = pubspec['name']
  s.version          = library_version
  s.summary          = pubspec['description']
  s.description      = <<-DESC
av_foundation is the full featured framework for working with time-based audiovisual media on iOS.
Using av_foundation, you can easily play, create, and edit QuickTime movies and MPEG-4 files, play
HLS streams, and build powerful media functionality into your apps.
                       DESC
  s.homepage         = pubspec['homepage']
  s.license          = { :type => 'MIT', :file => '../LICENSE' }
  s.author           = 'Maurice Parrish'
  s.source           = { :http => pubspec['homepage'] }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.dependency 'reference'
  s.platform = :ios, '10.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'VALID_ARCHS' => 'armv7 arm64 x86_64', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
end
