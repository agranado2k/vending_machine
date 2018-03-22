require 'rspec_helper'

describe Cleo::Change do
  let(:params) { { name: '5p', value: 5, quantity: 13 } }
  subject { described_class.new params }

  context 'when create' do
    it { expect(subject.cents).to eq(params[:value]) }
    it { expect(subject.name).to eq('5p') }
    it { expect(subject.quantity).to eq(params[:quantity]) }
  end

  it_behaves_like "a loadable object", 8
end
