require 'spec_helper'
require 'ostruct'

describe GitHub, '#limit_exceeded?' do
  let(:code) { 200 }
  let(:message) { '' }
  let(:response) { stub code: code, message: message }

  before { HTTParty.stub get: response }
  subject { GitHub.limit_exceeded? }

  context 'when the limit has not been exceeded' do
    let(:code) { 200 }
    it { should be_false }
  end

  context 'when the limit has been exceeded' do
    let(:code) { 400 }
    let(:message) { 'exceeded' }
    it { should be_true }
  end
end
