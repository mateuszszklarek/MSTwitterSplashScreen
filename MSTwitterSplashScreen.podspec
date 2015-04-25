Pod::Spec.new do |s|
  s.name         = "MSTwitterSplashScreen"
  s.version      = '1.0.2'
  s.summary      = 'Simple animation of splash screen like in Twitter App for iOS 7 & 8'
  s.homepage     = 'https://github.com/mateuszszklarek/MSTwitterSplashScreen.git'
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"
  s.license      = { :type => "MIT", :file => 'LICENSE' }
  s.author             = { "Mateusz Szklarek" => "mateusz.szklarek@icloud.com" }
  s.social_media_url   = "https://twitter.com/szklarekmateusz"
  s.platform     = :ios, '7.0'
  s.source       = { :git => 'https://github.com/mateuszszklarek/MSTwitterSplashScreen', :tag => 'v1.0.2' }
  s.source_files  = 'MSTwitterSplashScreen'
  s.requires_arc = true
end