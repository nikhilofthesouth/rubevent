$LOAD_PATH << File.expand_path('../../lib', __FILE__)
require 'rubevent'
require 'test/unit/assertions'

World(Test::Unit::Assertions)
