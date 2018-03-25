module Cleo
  class VendingMachine
    MONEY = {'1p' => 1, '2p' => 2 ,'5p' => 5, '10p' => 10, '20p' => 20, '50p' => 50, '£1' => 100, '£2' => 200}
    attr_accessor :ui, :products, :changes, :purchase, :output, :io, :purchasing

    def initialize(ui, io)
      @ui = ui
      @io = io
      @purchasing = false
    end

    def run
      init
      start
      io.output(output)

      while true do
        command = io.input
        if command == 'r' || command == 'c'
          init if command == 'r'
          start
          io.output(output)
          next
        end

        if purchasing?
          insert_money(command)
        else
          purchase_process(command)
        end
        io.output(output)
      end
    end

    def purchasing?
      purchasing
    end

    def start
      @output = ui.template_index(products.values, changes.values, false)
    end

    def init
      @products = Cleo::Product.load
      @changes = Cleo::Change.load
      self
    end

    def purchase_process(product_id)
      product = products.values.select{|p| p.code == product_id.to_i}.first
      if product.nil?
        @output = ui.template_index(products.values, changes.values, true)
        return
      end

      @purchase = Purchase.new(product: product, calculator: ChangeCalculator.new(changes))
      @purchasing = true

      @output = ui.template_checkout(purchase, changes.values)
    end

    def insert_money(money_id)
      if !MONEY.has_key?(money_id)
        @output = ui.template_checkout(purchase, changes.values, true)
        return
      end

      money = Money.new(MONEY[money_id], CURRENCY)
      purchase.insert(money)

      @output = ui.template_checkout(purchase, changes.values)
    end

    def self.execute
      VendingMachine.new(UserInterface.new, IOInterface.new).run
    end
  end
end

