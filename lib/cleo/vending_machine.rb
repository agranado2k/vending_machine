module Cleo
  class VendingMachine
    MONEY = {'1p' => 1, '2p' => 2 ,'5p' => 5, '10p' => 10, '20p' => 20, '50p' => 50, '£1' => 100, '£2' => 200}
    attr_accessor :ui, :products, :changes, :purchase, :output

    def initialize(ui)
      @ui = ui
    end

    def start
      init
      @output = ui.template_index(products.values, false)
    end

    def purchase_process(product_id)
      product = products.values.select{|p| p.code == product_id}.first
      if product.nil?
        @output = ui.template_index(products.values, true)
        return
      end

      @purchase = Purchase.new(product: product, calculator: ChangeCalculator.new(changes))

      @output = ui.template_checkout(purchase)
    end

    def insert_money(money_id)
      if !MONEY.has_key?(money_id)
        @output = ui.template_checkout(purchase, true)
        return
      end

      money = Money.new(MONEY[money_id], CURRENCY)
      purchase.insert(money)

      @output = ui.template_checkout(purchase)
    end

    def init
      @products = Cleo::Product.load
      @changes = Cleo::Change.load
      self
    end
  end
end
