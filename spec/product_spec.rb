require 'rspec_helper'

describe Cleo::Product do
  let(:params) { { name: 'product_1', price: 2.50, quantity: 3 } }
  subject { described_class.new params }

  context 'when create' do
    it { expect(subject.name).to eq(params[:name]) }
    it { expect(subject.price).to eq(params[:price]) }
    it { expect(subject.quantity).to eq(params[:quantity]) }
  end
end
