require 'serverspec'

set :backend, :exec

describe command('git --version') do
  its(:stdout) { should contain 'git version 2' }
end
