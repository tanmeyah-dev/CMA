Pod::Spec.new do |s|
  s.name             = 'flutter_icmp_ping'
  s.version          = '3.1.3'
  s.summary          = 'Flutter plugin that sends ICMP ECHO_REQUEST to network hosts.'
  s.description      = <<-DESC
Flutter plugin that sends ICMP ECHO_REQUEST to network hosts.
                       DESC
  s.homepage         = 'https://github.com/zuvola/flutter_icmp_ping'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'zuvola' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'flutter_icmp_ping/Sources/flutter_icmp_ping/**/*.swift', 'flutter_icmp_ping/Sources/GBPingObjC/**/*.{h,m}'
  s.dependency 'Flutter'
  s.platform = :ios, '13.0'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
