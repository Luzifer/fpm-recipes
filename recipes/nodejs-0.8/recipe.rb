# Adapted from the formula in brew2deb.

class NodeJS < FPM::Cookery::Recipe
  description 'Evented I/O for V8 JavaScript'

  name     'nodejs'
  version  '0.8.26'
  revision 0
  homepage 'http://nodejs.org/'
  source   "http://nodejs.org/dist/v#{version}/node-v#{version}.tar.gz"
  sha256   'd873216685774b96139af534ce015077d2c93ddfc4e3596e128853f3c08a5413'

  section 'interpreters'

  build_depends 'libssl-dev', 'g++', 'python'
  depends       'openssl'

  def build
    configure :prefix => prefix, :debug => true
    make
  end

  def install
    make :install, 'DESTDIR' => destdir

    # https://github.com/joyent/node/issues/2192
    prefix('lib/node_modules/npm/man/man1').mkpath
  end
end
