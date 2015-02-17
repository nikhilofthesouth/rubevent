Gem::Specification.new do |s|
  s.name        = 'rubevent'
  s.version     = '0.1.1'
  s.date        = '2015-02-17'
  s.summary     = 'RubEvent event loop'
  s.description = 'Minimal event loop written in Ruby'
  s.author      = 'Nikhil Narula'
  s.email       = 'yahoo.is.amazing@gmail.com'
  s.homepage    = 'https://github.com/nn2242/rubevent'
  s.files       = Dir['bin/*', 'lib/**/*.rb']
  s.executables << 'rubevent'
  s.license     = 'MIT'

  s.add_runtime_dependency 'slop', '~> 4.0'
end
