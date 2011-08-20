Gem::Specification.new {|s|
    s.name         = 'bitmap'
    s.version      = '0.0.3'
    s.author       = 'meh.'
    s.email        = 'meh@paranoici.org'
    s.homepage     = 'http://github.com/meh/ruby-bitmap'
    s.platform     = Gem::Platform::RUBY
    s.summary      = 'Simple and stupid bitmap implementation (bitmap as in bitset, not bitmap image)'
    s.files        = Dir.glob('lib/**/*.rb')
    s.require_path = 'lib'
}
