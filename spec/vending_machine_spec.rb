require 'rspec_helper'

describe Cleo::VendingMachine do
  context 'when init' do
    before(:each) { subject.init }

    context 'load products' do
      it 'product list' do
        expect(subject.products.size).to eq(3)
      end
    end

    context 'load changes' do
      it 'change list' do
        expect(subject.changes.size).to eq(8)
      end
    end
  end

  describe Cleo::Purchase do
    let(:product) { double('Product', price: 2.75) }
    let(:params) { { product: product } }
    subject { described_class.new params }

    context 'purchase process' do
      context 'choose a product' do
        it { expect(subject.product).to_not be_nil }
        it { expect(subject.total).to eq(product.price) }
        it { expect(subject.paid).to eq(0) }
        it { expect(subject.balance).to eq(product.price*-1) }
        it { expect(subject.change).to eq(0) }
      end

      context 'check out payment' do
          let(:money_2) { double('Money 2', value: 2) }
          let(:money_050) { double('Money 0.50', value: 0.5) }
          let(:money_020) { double('Money 0.20', value: 0.2) }
          let(:money_010) { double('Money 0.10', value: 0.10) }
          let(:money_005) { double('Money 0.05', value: 0.05) }
        context 'insert insufficient payment' do
          before(:each) { subject.insert money_010 }

          it { expect(subject.total).to eq(product.price) }
          it { expect(subject.paid).to eq(money_010.value) }
          it { expect(subject.balance).to eq(money_010.value- product.price) }
          it { expect(subject.change).to eq(0) }
          it { expect(subject.message).to eq('Insufficient money. Insert more, please.') }
        end

        context 'insert exactaly the price as payment' do
          before(:each) do
            subject.insert money_2
            subject.insert money_050
            subject.insert money_020
            subject.insert money_005
          end

          it { expect(subject.total).to eq(product.price) }
          it { expect(subject.paid).to eq(product.price) }
          it { expect(subject.balance).to eq(0) }
          it { expect(subject.change).to eq(0) }
          it { expect(subject.message).to eq('Payment completed') }
        end

        context 'insert more than the price as payment' do
          before(:each) do
            subject.insert money_2
            subject.insert money_2
          end

          it { expect(subject.total).to eq(product.price) }
          it { expect(subject.paid).to eq(2*money_2.value) }
          it { expect(subject.balance).to eq((2*money_2.value) - product.price) }
          it { expect(subject.change).to eq((2*money_2.value) - product.price) }
          it { expect(subject.message).to eq('Payment completed. Get your change!') }
        end
      end
    end
  end

  context 'calculate change' do

  end
end
