require 'rspec_helper'

describe Cleo::VendingMachine do
  let(:ui) { Cleo::UserInterface.new }
  subject { described_class.new(ui) }

  context 'when init' do
    before(:each) { subject.init }

    context 'load products' do
      it 'product list' do
        expect(subject.products.keys.size).to eq(3)
      end
    end

    context 'load changes' do
      it 'change list' do
        expect(subject.changes.keys.size).to eq(8)
      end
    end
  end

  context 'Start Vending Mahine' do
    before { subject.start }
    let(:message) do
      <<~EOT
      #############################################
      ############ Vending Machine ################
      #############################################
      Changes: [2x£2,5x£1,10x50p,10x20p,20x10p,50x5p,60x2p,100x1p]
      (press r any time to reload system)

      *** Plese Select one Product by code***
      code |  product  | price | quantity
      --------------------------------------
        1  | Product 1 | £2.55 | 12
      --------------------------------------
        2  | Product 2 | £13.70 | 2
      --------------------------------------
        3  | Product 3 | £5.60 | 20

      Insert product code:
      EOT
    end

    it { expect(subject.output).to eq(message) }
  end

  context 'Purchase process' do
    context 'Chose valid product' do
      let(:product_2_id) { 2 }
      before do
        subject.start
        subject.purchase_process(product_2_id)
      end
      let(:message) do
        <<~EOT
        #############################################
        ############ Vending Machine ################
        #############################################
        Changes: [2x£2,5x£1,10x50p,10x20p,20x10p,50x5p,60x2p,100x1p]
        (press r any time to reload system)

        *** You're buying the product:***
        code |  product  | price | quantity
        --------------------------------------
          2  | Product 2 | £13.70 | 2

        Checkout:
        total: £13.70
        paid: £0.00
        balance: £-13.70
        due change: £0.00

        Insert one of the follow valeus
        (1p, 2p ,5p, 10p, 20p, 50p, £1, £2)
        EOT
      end

      it { expect(subject.output).to eq(message) }
    end

    context 'Chose invalid product' do
      let(:invalid_product_id) { 5 }
      before do
        subject.start
        subject.purchase_process(invalid_product_id)
      end
      let(:message) do
        <<~EOT
        #############################################
        ############ Vending Machine ################
        #############################################
        Changes: [2x£2,5x£1,10x50p,10x20p,20x10p,50x5p,60x2p,100x1p]
        (press r any time to reload system)

        *** Plese Select one Product by code***
        code |  product  | price | quantity
        --------------------------------------
          1  | Product 1 | £2.55 | 12
        --------------------------------------
          2  | Product 2 | £13.70 | 2
        --------------------------------------
          3  | Product 3 | £5.60 | 20

        ** Invalid product code **

        Insert product code:
        EOT
      end

      it { expect(subject.output).to eq(message) }
    end

    context 'Inserting money' do
      context 'Invalid money' do
        let(:product_2_id) { 2 }
        let(:invalid_money_id) { '2' }
        before do
          subject.start
          subject.purchase_process(product_2_id)
          subject.insert_money(invalid_money_id)
        end
        let(:message) do
          <<~EOT
          #############################################
          ############ Vending Machine ################
          #############################################
          Changes: [2x£2,5x£1,10x50p,10x20p,20x10p,50x5p,60x2p,100x1p]
          (press r any time to reload system)

          *** You're buying the product:***
          code |  product  | price | quantity
          --------------------------------------
            2  | Product 2 | £13.70 | 2

          Checkout:
          total: £13.70
          paid: £0.00
          balance: £-13.70
          due change: £0.00

          ** Invalid money **

          Insert one of the follow valeus
          (1p, 2p ,5p, 10p, 20p, 50p, £1, £2)
          EOT
        end

        it { expect(subject.output).to eq(message) }
      end

      context 'Insufficient money' do
        let(:product_2_id) { 2 }
        let(:money_id) { '£2' }
        before do
          subject.start
          subject.purchase_process(product_2_id)
          subject.insert_money(money_id)
          subject.insert_money(money_id)
          subject.insert_money(money_id)
          subject.insert_money(money_id)
          subject.insert_money(money_id)
        end
        let(:message) do
          <<~EOT
          #############################################
          ############ Vending Machine ################
          #############################################
          Changes: [2x£2,5x£1,10x50p,10x20p,20x10p,50x5p,60x2p,100x1p]
          (press r any time to reload system)

          *** You're buying the product:***
          code |  product  | price | quantity
          --------------------------------------
            2  | Product 2 | £13.70 | 2

          Checkout:
          total: £13.70
          paid: £10.00
          balance: £-3.70
          due change: £0.00

          ** Insufficient money. Insert more, please. **

          Insert one of the follow valeus
          (1p, 2p ,5p, 10p, 20p, 50p, £1, £2)
          EOT
        end

        it { expect(subject.output).to eq(message) }
      end

      context 'Exact money' do
        let(:product_2_id) { 2 }
        let(:money_200_id) { '£2' }
        let(:money_100_id) { '£1' }
        let(:money_50_id) { '50p' }
        let(:money_20_id) { '20p' }
        before do
          subject.init
          subject.purchase_process(product_2_id)
          subject.insert_money(money_200_id)
          subject.insert_money(money_200_id)
          subject.insert_money(money_200_id)
          subject.insert_money(money_200_id)
          subject.insert_money(money_200_id)
          subject.insert_money(money_200_id)
          subject.insert_money(money_100_id)
          subject.insert_money(money_50_id)
          subject.insert_money(money_20_id)
        end
        let(:message) do
          <<~EOT
          #############################################
          ############ Vending Machine ################
          #############################################
          Changes: [2x£2,5x£1,10x50p,10x20p,20x10p,50x5p,60x2p,100x1p]
          (press r any time to reload system)

          *** You're buying the product:***
          code |  product  | price | quantity
          --------------------------------------
            2  | Product 2 | £13.70 | 2

          Checkout:
          total: £13.70
          paid: £13.70
          balance: £0.00
          due change: £0.00

          ** Payment completed **

          (press c to keep bying)
          EOT
        end

        it { expect(subject.output).to eq(message) }
      end

      context 'More money than price' do
        let(:product_2_id) { 2 }
        let(:money_200_id) { '£2' }
        let(:money_100_id) { '£1' }
        before do
          subject.init
          subject.purchase_process(product_2_id)
          subject.insert_money(money_200_id)
          subject.insert_money(money_200_id)
          subject.insert_money(money_200_id)
          subject.insert_money(money_200_id)
          subject.insert_money(money_200_id)
          subject.insert_money(money_200_id)
          subject.insert_money(money_200_id)
          subject.insert_money(money_100_id)
        end
        let(:message) do
          <<~EOT
          #############################################
          ############ Vending Machine ################
          #############################################
          Changes: [2x£2,5x£1,10x50p,10x20p,20x10p,50x5p,60x2p,100x1p]
          (press r any time to reload system)

          *** You're buying the product:***
          code |  product  | price | quantity
          --------------------------------------
            2  | Product 2 | £13.70 | 2

          Checkout:
          total: £13.70
          paid: £15.00
          balance: £1.30
          due change: £1.30

          ** Payment completed. Get your change! **

          (changes: 1x£1, 1x20p, 1x10p)

          (press c to keep bying)
          EOT
        end

        it { expect(subject.output).to eq(message) }
      end
    end
  end

  context 'Purchase process' do
    let(:value) { Money.new(275, Cleo::CURRENCY) }
    let(:product) { double('Product', value: value, price: value.format) }
    let(:params) { { product: product } }

    subject { Cleo::Purchase.new params }

    context 'purchase process' do
      context 'choose a product' do
        it { expect(subject.product).to_not be_nil }
        it { expect(subject.total).to eq(product.value) }
        it { expect(subject.paid).to eq(0) }
        it { expect(subject.balance).to eq(product.value*-1) }
        it { expect(subject.change).to eq(0) }
      end

      context 'check out payment' do
        let(:money_2) { Money.new( 200, Cleo::CURRENCY) }
        let(:money_050) { Money.new( 50, Cleo::CURRENCY) }
        let(:money_020) { Money.new( 20, Cleo::CURRENCY) }
        let(:money_010) { Money.new( 10, Cleo::CURRENCY) }
        let(:money_005) { Money.new( 5, Cleo::CURRENCY) }

        context 'insert insufficient payment' do
          before(:each) { subject.insert money_010 }

          it { expect(subject.total).to eq(product.value) }
          it { expect(subject.paid).to eq(money_010) }
          it { expect(subject.balance).to eq(money_010 - product.value) }
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

          it { expect(subject.total).to eq(product.value) }
          it { expect(subject.paid).to eq(product.value) }
          it { expect(subject.balance).to eq(0) }
          it { expect(subject.change).to eq(0) }
          it { expect(subject.message).to eq('Payment completed') }
        end

        context 'insert more than the price as payment' do
          before(:each) do
            subject.insert money_2
            subject.insert money_2
          end

          it { expect(subject.total).to eq(product.value) }
          it { expect(subject.paid).to eq(2*money_2) }
          it { expect(subject.balance).to eq((2*money_2) - product.value) }
          it { expect(subject.change).to eq((2*money_2) - product.value) }
          it { expect(subject.message).to eq('Payment completed. Get your change!') }
        end
      end
    end
  end
end
