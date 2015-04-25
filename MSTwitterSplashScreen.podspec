Pod::Spec.new do |s|

  s.name         = "MSTwitterSplashScreen"
  s.version      = "1.0.0"
  s.summary      = "Simple animation of splash screen like in Twitter App"

  s.description  = <<-DSimple animati…ESC
                   A longer description of Peanut in Markdown format.

                   * Think: Why did you write this? What is the focus? What does it do?
                   * CocoaPods will be using this to generate tags, and improve search results.
                   * Try to keep it short, snappy and to the point.
                   * Finally, don't worry about the indent, CocoaPods strips it!
                   DESC

  s.homepage     = 'https://github.com/mateuszszklarek/MSTwitterSplashScreen.git'
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"
  s.license      = { :type => "MIT", :file => 'LICENSE' }
  s.author             = { "Mateusz Szklarek" => "mateusz.szklarek@icloud.com" }
  s.social_media_url   = "https://twitter.com/szklarekmateusz"
  #s.platform     = :ios
  s.platform     = :ios, '7', '8'
  # s.ios.deployment_target = "5.0"
  s.source_files  = "MSTwitterSplashScreen", "/**/*.{h}"
  #s.source_files  = "MSTwitterSplashScreen", "MSTwitterSplashScreen/**/*.{h,m}"
  #s.exclude_files = "Classes/Exclude"
  s.public_header_files = "Classes/**/*.h"

  s.framework  = 'CBZSplashView'
  # s.frameworks = "SomeFramework", "AnotherFramework"

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"
  s.requires_arc = true

end
