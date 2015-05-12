Pod::Spec.new do |s|
  s.name     = 'CPAccelerationTimer'
  s.version  = '0.0.2'
  s.platform = :ios
  s.license  = { :type => 'MIT', :file => 'LICENSE' }
  s.summary  = 'Timer with Bézier curve acceleration'
  s.homepage = 'https://github.com/yangmeyer/CPAccelerationTimer'
  s.author   = { 'Yang Meyer' => 'https://github.com/yangmeyer' }
  s.description = 'Calls a block a given number of times, spread out over a given duration, with the between-calls delays determined by a given Bézier curve. Think of it as an NSTimer with custom acceleration.'
  
  s.source   = { :git => 'https://github.com/yangmeyer/CPAccelerationTimer.git', :tag => s.version.to_s }
  s.source_files = 'Component/*.{h,c,m}'
  s.requires_arc = true
end
