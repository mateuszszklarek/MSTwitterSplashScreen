Pod::Spec.new do |s|
  s.name         = "MSTwitterSplashScreen"
  s.version      = "1.0.1"
  s.summary      = "Simple animation of splash screen like in Twitter App for iOS 7 & 8"
  s.homepage     = "https://github.com/mateuszszklarek/MSTwitterSplashScreen.git"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"
  s.license      = { :type => "MIT", :file => 'LICENSE' }
  s.author             = { "Mateusz Szklarek" => "mateusz.szklarek@icloud.com" }
  s.social_media_url   = "https://twitter.com/szklarekmateusz"
  s.platform     = :ios, '7.0'
  #s.ios.deployment_target = "7.0"
  s.source       = { :git => 'https://github.com/mateuszszklarek/MSTwitterSplashScreen', :tag => 'v1.0.1' }
  s.source_files  = 'MSTwitterSplashScreen'

  #s.source_files  = 'MSTwitterSplashScreen', '*.{h,m}' "MSTwitterSplashScreen/**/*.{h,m}"
  
  
  #s.source_files  = "MSTwitterSplashScreen", "MSTwitterSplashScreen/**/*.{h,m}"
  #s.exclude_files = "Classes/Exclude"
  #s.public_header_files = "Classes/**/*.h"

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"
  s.requires_arc = true

end
