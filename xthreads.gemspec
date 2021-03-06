Gem::Specification.new do |s|
  s.name = 'xthreads'
  s.version = '0.1.7'
  s.summary = 'xthreads'
    s.authors = ['James Robertson']
  s.files = Dir['lib/**/*.rb'] 
  s.signing_key = '../privatekeys/xthreads.pem'
  s.cert_chain  = ['gem-public_cert.pem']
  s.license = 'MIT'
  s.email = 'james@r0bertson.co.uk'
  s.homepage = 'https://github.com/jrobertson/xthreads'
  s.required_ruby_version = '>= 2.1.2'
end
