Pod::Spec.new do |s|

  s.name             = 'CRUploadLib'
  s.version          = '1.0.1'
  s.summary          = 'iOS library for upload media files in server'
  
  
  s.homepage         = 'https://github.com/vkrotin/CRUploadLib'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Aleksey Anisimov' => 'anisimov@cyrm.ru' }
  s.source           = { :git => 'https://github.com/vkrotin/CRUploadLib.git', :tag => "#{s.version}" }
  #s.ios.deployment_target = '14.0'
  
  s.ios.deployment_target = "14.1"
  s.swift_version = "5.0"

  s.vendored_frameworks = 'Sources/CRUploadLib.xcframework'
  s.frameworks = 'Foundation', 'CoreData'
  s.requires_arc = true
#  s.pod_target_xcconfig = {
#    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64'
#  }
#  s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }

end
