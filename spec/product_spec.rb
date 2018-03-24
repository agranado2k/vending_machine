require 'rspec_helper'

describe Cleo::Product do
  let(:params) { { code: 1, name: 'product_1', value: 2.50, quantity: 3 } }
  subject { described_class.new params }

  context 'when create' do
    it { expect(subject.code).to eq(params[:code]) }
    it { expect(subject.name).to eq(params[:name]) }
    it { expect(subject.value).to eq(Money.new(params[:value]*100, Cleo::CURRENCY)) }
    it { expect(subject.quantity).to eq(params[:quantity]) }
    it { expect(subject.price).to eq('£2.50') }
  end

  it_behaves_like "a loadable object", 3
end
