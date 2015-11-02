require 'spec_helper'

describe 'scpr-transcoder::default' do
  describe service("transcoder") do
    it { should be_running }
  end

  describe port(8000) do
    it { should be_listening }
  end

end
