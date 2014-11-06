require 'spec_helper'

describe 'bamboo_agent::private_tmp' do

  let :title do '/footmp' end

  let(:params) do
    {
      :user   => 'jdoe', 
      :group  => 'jdoe', 
    }
  end  

  it do
    should contain_file('/footmp').with({
      :ensure => 'directory',
      :owner  => 'jdoe',
      :group  => 'jdoe',
      :mode   => '0755',
    })
    should contain_package('tmpwatch')
    should contain_cron('/footmp-tmp-cleanup').with({
      :command => '/usr/sbin/tmpwatch 10d /footmp',
      :minute  => 15,
    })
  end
end
