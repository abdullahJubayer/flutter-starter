Pod::Spec.new do |s|
  s.name             = 'native_bridge'
  s.version          = '0.0.1'
  s.summary          = 'Native Bridge FFI library'
  s.description      = 'Statically links the C++ FFI code for iOS'
  s.homepage         = 'https://github.com/flutter'
  s.license          = { :type => 'BSD' }
  s.author           = { 'Team' => 'dev@example.com' }
  s.source           = { :path => '.' }

  s.platform         = :ios, '12.0'

  # Path to the compiled xcframework relative to this podspec
  s.vendored_frameworks = 'Runner/native_bridge.xcframework'

  # Include dummy C file to prevent symbol stripping
  s.source_files     = 'FFIDummy.c'

  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
end
