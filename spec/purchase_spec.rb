require 'rspec_helper'

describe Cleo::Purchase do
  let(:product) { double('product', price: 2.54) }
  let(:params) { { product: product } }
  subject { described_class.new params }

  it { expect(subject.product).to eq(product) }
  it { expect(subject.total).to eq(product.price) }
  it { expect(subject.paid).to eq(0) }
  it { expect(subject.balance).to eq(product.price*-1) }
  it { expect(subject.change).to eq(0) }
  it { expect(subject.change_list).to be_empty }
end
