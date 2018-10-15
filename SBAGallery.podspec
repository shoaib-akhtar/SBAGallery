Pod::Spec.new do |s|
  s.name         = "SBAGallery"
  s.version      = "1.0"
  s.summary      = "Easy to use gallery controller"
  s.homepage     = "https://github.com/shoaib-akhtar/SBAGallery"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "Shoaib Akhtar" => "shoaib.akhtar1@live.com" }
  s.source       = { :git => "https://github.com/shoaib-akhtar/SBAGallery.git", :branch => "master",
                     :tag => s.version.to_s }
  s.platform     = :ios, '11.0'
  s.requires_arc = true
  s.source_files = "SBAGallery/*.swift"
  s.resource_bundles = { "SBAGallery" => "SBAGallery/*.{lproj,storyboard}" }
  s.resource = 'SBAGallery/SBAGallery.storyboard'
  s.frameworks   = 'Foundation', 'UIKit'
  s.swift_version = '4.2'
  s.dependency "Hero", "1.4.0"
end
