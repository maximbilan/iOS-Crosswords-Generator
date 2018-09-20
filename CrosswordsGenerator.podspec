Pod::Spec.new do |s|
s.name         = "CrosswordsGenerator"
s.version      = "0.3.4"
s.summary      = "Crosswords Generator"
s.description  = "iOS Swift Crosswords Generator"
s.homepage     = "https://github.com/maximbilan/iOS-Crosswords-Generator"
s.license      = { :type => "MIT" }
s.author       = { "Maxim Bilan" => "maximb.mail@gmail.com" }
s.platform     = :ios, "8.0"
s.source       = { :git => "https://github.com/maximbilan/iOS-Crosswords-Generator.git", :tag => s.version.to_s }
s.source_files = "Classes", "crosswords_generator/Sources/**/*.{swift}"
s.requires_arc = true
end