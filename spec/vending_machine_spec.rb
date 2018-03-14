require 'rspec'
require_relative '../lib/cleo'

describe Cleo::VendingMachine do
  context 'when init' do
    context 'load products' do
      it 'product list' do
        expect(subject.product_list.size).to eq(3)
      end
    end

    context 'load changes' do
      it 'change list' do
        expect(subject.change_list.size).to eq(8)
      end
    end
  end

  describe Cleo::Purchase do
    context 'purchase process' do
      context 'choose a product' do
        it { expect(subject.product).to_not be_nil }
        it { expect(subject.total).to eq(product.price) }
        it { expect(subject.paid).to eq(0) }
        it { expect(subject.balance).to eq(product.price*-1) }
        it { expect(subject.status).to eq('pending') }
        it { expect(subject.change).to eq(0) }
        it { expect(subject.change_list).to be_empty }
      end

      context 'check out payment' do
        context 'insert insufficient payment' do
          it { expect(subject.total).to eq(product.price) }
          it { expect(subject.paid).to eq(value_inserted) }
          it { expect(subject.balance).to eq(value_inserted - product.price) }
          it { expect(subject.status).to eq('pending') }
          it { expect(subject.change).to eq(0) }
          it { expect(subject.change_list).to be_empty }
          it { expect(subject.message).to eq('Insufficient money. Insert more, please.') }
        end

        context 'insert exactaly the price as payment' do
          it { expect(subject.total).to eq(product.price) }
          it { expect(subject.paid).to eq(product.price) }
          it { expect(subject.balance).to eq(0) }
          it { expect(subject.status).to eq('paid') }
          it { expect(subject.change).to eq(0) }
          it { expect(subject.change_list).to be_empty }
          it { expect(subject.message).to eq('Payment completed') }
        end

        context 'insert more than the price as payment' do
          it { expect(subject.total).to eq(product.price) }
          it { expect(subject.paid).to eq(value_inserted) }
          it { expect(subject.balance).to eq(value_inserted - product.price) }
          it { expect(subject.status).to eq('paid') }
          it { expect(subject.change).to eq(value_inserted - product.price) }
          it { expect(subject.change_list).to_not be_empty }
          it { expect(subject.message).to eq('Payment completed. Get your change!') }
        end
      end
    end
  end

  context 'calculate change' do

  end
end
