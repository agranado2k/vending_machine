require 'rspec_helper'

describe Cleo::Change do
  let(:params) { { name: '5p', value: 0.05, quantity: 13 } }
  subject { described_class.new params }

  context 'when create' do
    it { expect(subject.name).to eq(params[:name]) }
    it { expect(subject.value).to eq(params[:value]) }
    it { expect(subject.quantity).to eq(params[:quantity]) }
  end
end
