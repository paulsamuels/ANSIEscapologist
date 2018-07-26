Pod::Spec.new do |s|
  s.name             = 'ANSIEscapologist'
  s.version          = '0.1.0'
  s.summary          = 'A library for converting a string with ANSI codes into an NSAttributedString'
  s.description      = <<-DESC
A library for converting a string with ANSI codes into an NSAttributedString. Handy
for situations where you want to show command line tool output that is styled with ANSI
control codes.
                       DESC
  s.swift_version         = "4.0"
  s.homepage              = 'https://github.com/paulsamuels/ANSIEscapologist'
  s.license               = { :type => 'MIT', :file => 'LICENSE' }
  s.author                = { 'paulsamuels' => 'paulio1987@gmail.com' }
  s.source                = { :git => 'https://github.com/paulsamuels/ANSIEscapologist.git', :tag => s.version.to_s }
  s.social_media_url      = 'https://twitter.com/paulio87'
  s.ios.deployment_target = '8.0'
  s.source_files          = 'ANSIEscapologist/Classes/**/*'
  
  s.test_spec 'Tests' do |test_spec|
    test_spec.source_files = 'ANSIEscapologist/Tests/**/*'
  end
end
