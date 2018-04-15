
Pod::Spec.new do |s|
  s.name             = 'Fuzzi'
  s.version          = '0.1.1'
  s.summary          = 'Locally searching in Swift made simple (and fuzzily)'

  s.description      = 'Locally searching in Swift made simple (and fuzzily)'

  s.homepage         = 'https://github.com/mathiasquintero/Fuzzi'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'mathiasquintero' => 'me@quintero.io' }
  s.source           = { :git => 'https://github.com/mathiasquintero/Fuzzi.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/nerdsupremacist'
  s.swift_version = "4.1"

  s.ios.deployment_target = '8.0'

  s.source_files = 'Fuzzi/Classes/**/*'
  
end
