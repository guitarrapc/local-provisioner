require 'spec_helper'
set :backend, :exec

describe file('/etc/pam.d/sudo') do
    it { should contain '# sudo: auth account password session' }
    it { should contain 'auth       sufficient     pam_tid.so' }
    it { should contain 'auth       sufficient     pam_smartcard.so' }
    it { should contain 'account    required       pam_permit.so' }
    it { should contain 'password   required       pam_deny.so' }
    it { should contain 'session    required       pam_permit.so' }
end
