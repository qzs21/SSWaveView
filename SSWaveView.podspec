Pod::Spec.new do |s|
  s.name     = 'SSWaveView'
  s.version  = '1.0.2'
  s.license  = { :type => 'MIT' }
  s.summary  = 'Wave view. Like water.'
  s.homepage = 'http://www.isteven.cn'
  s.authors  = { 'Steven' => 'qzs21@qq.com' }
  s.source   = {
    :git => 'https://github.com/qzs21/SSWaveView.git',
    :tag => s.version
  }
  s.source_files = 'Classes/*.{h,m}'
  s.requires_arc = true
  s.ios.deployment_target = '5.0'
  s.ios.frameworks = 'CoreMotion'
end
