Pod::Spec.new do |s|
s.name         = "CrosswordsGenerator"
s.version      = "0.2.3"
s.summary      = "Crosswords Generator"
s.description  = "iOS Swift Crosswords Gemerator"
s.homepage     = "https://github.com/maximbilan/ios_crosswords_generator"
s.license      = { :type => "MIT" }
s.author       = { "Maxim Bilan" => "maximb.mail@gmail.com" }
s.platform     = :ios, "8.0"
s.source       = { :git => "https://github.com/maximbilan/ios_crosswords_generator.git", :tag => "0.2.3" }
s.source_files = "Classes", "crosswords_generator/Sources/**/*.{swift}"
s.requires_arc = true
end