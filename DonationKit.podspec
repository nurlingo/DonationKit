Pod::Spec.new do |spec|
  spec.name         = "DonationKit"
  spec.version      = "0.0.1"
  spec.summary      = "DonationKit."

  spec.description  = "DonationKit."

  spec.homepage     = "homepage"
  spec.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  spec.author             = { "IOSerler" => "github.com/IOSerler" }
  spec.source       = { :git => "local", :tag => "#{spec.version}" }

  spec.prefix_header_file = false
  spec.ios.deployment_target = 9.0
  
  spec.source_files  = "Classes", "Classes/**/*.{h,m}"
  spec.exclude_files = "Classes/Exclude"

  spec.source_files = [
    'DonationKit/**/*.{swift,h,m,json}'
  ]

  spec.dependency 'SwiftConfettiView'

end
