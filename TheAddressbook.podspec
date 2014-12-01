Pod::Spec.new do |s|
  s.name         = "TheAddressbook"
  s.version      = "0.0.3"
  s.summary      = "A wrapper for the iOS AddressBook framework"
  s.homepage     = "https://github.com/sambame/TheAddressbook.git"
  s.license      = 'Apache License Version 2.0'
  s.author       = { "Shay Erlichmen" => "shay@samba.me" }
  s.source       = { :git => "https://github.com/sambame/TheAddressbook.git", :tag => "0.0.3" }
  s.source_files = 'Classes', 'Classes/**/*.{h,m}'
  s.frameworks   = 'AddressBook' 
  s.platform     = :ios
  s.requires_arc = true
end
