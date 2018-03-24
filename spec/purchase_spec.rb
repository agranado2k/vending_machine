require 'rspec_helper'

describe Cleo::Purchase do
  let(:value) { Money.new(254, Cleo::CURRENCY) }
  let(:product) { double('product', value: value) }
  let(:params) { { product: product } }
  subject { described_class.new params }

  it { expect(subject.product).to eq(product) }
  it { expect(subject.total).to eq(product.value) }
  it { expect(subject.paid).to eq(Money.new(0, Cleo::CURRENCY)) }
  it { expect(subject.balance).to eq(product.value*-1) }
  it { expect(subject.change).to eq(Money.new(0, Cleo::CURRENCY)) }

  context 'insert money' do
    let(:money) { Money.new(0.1*100, Cleo::CURRENCY) }
    before(:each) { subject.insert money }

    it { expect(subject.paid).to eq(money) }

    context 'more times' do
      let(:money_1) { Money.new(1*100, Cleo::CURRENCY) }
      before(:each) { subject.insert money_1 }

      it { expect(subject.paid).to eq(money + money_1) }
    end
  end
end
