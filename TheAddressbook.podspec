Pod::Spec.new do |s|
  s.name         = "TheAddressbook"
  s.version      = "0.0.2"
  s.summary      = "A wrapper for the iOS AddressBook framework"
  s.homepage     = "https://github.com/sambame/Adressbook"
  s.license      = 'Apache License Version 2.0'
  s.author       = { "Shay Erlichmen" => "shay@samba.me" }
  s.source       = { :git => "https://github.com/sambame/Adressbook.git", :tag => "0.0.2" }
  s.source_files = 'Classes', 'Classes/**/*.{h,m}'
  s.frameworks   = 'AddressBook' 
  s.platform     = :ios
  s.requires_arc = true
end
