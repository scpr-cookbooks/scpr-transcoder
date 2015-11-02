require 'spec_helper'

describe 'scpr-transcoder::default' do
  # node should be 4.x
  describe command("node --version") do
    its(:exit_status) { should eql 0 }
    its(:stdout) { should contain "v4" }
  end

  # transcoder runner should be installed and executable
  describe file("/scpr/transcoder/transcoder-cmd") do
    it { should exist }
    it { should be_file }
    it { should be_executable }
  end

  describe command("/scpr/transcoder/transcoder-cmd --help") do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should contain "Usage" }
  end

  # transcoder service should be running
  describe service("transcoder") do
    it { should be_running }
  end

  # consul should have a healthy service
  describe command("/etc/consul_checks/transcoder-prod") do
    its(:exit_status) { should eq 0 }
  end

  describe command("curl http://localhost:8500/v1/catalog/service/transcoder-prod") do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should contain '"ServiceName":"transcoder-prod"'}
  end
end
