require 'spec_helper'

describe 'rocketchat::packages' do
  on_supported_os.each do |os, facts|
    let(:facts) do
      facts
    end

    let(:pre_condition) {
      "class { 'rocketchat::install':
        download_path => '/tmp',
        destination =>'/tmp',
        package_ensure => 'latest',
        package_source => undef
 }"
    }

    context "with default values on #{os}" do
      context 'it should compile' do
        it { is_expected.to compile.with_all_deps }
      end

      context 'it should contain all classes' do
        it { is_expected.to contain_class('nodejs') }
        it { is_expected.to contain_class('nodejs').that_comes_before("Exec[npm install]")}
        it { is_expected.to contain_package('curl') }
        it { is_expected.to contain_package('graphicsmagick') }
        it { is_expected.to contain_package('build-essential') }
      end
    end
  end
end
