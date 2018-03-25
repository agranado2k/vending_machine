module Cleo
  class Purchase
    attr_accessor :product, :money, :calculator

    def initialize(params)
      @calculator = params[:calculator]
      @product = params[:product]
      @money = []
    end

    def total
      product.value
    end

    def balance
      paid - total
    end

    def insert(money)
      @money << money
      product.quantity -= 1 if paid > total
    end

    def paid
      money.reduce(Money.new(0, CURRENCY)){|r, m| r += m}
    end

    def change
      return Money.new(0, CURRENCY) if paid <= total
      paid - total
    end

    def changes
      calculator.calculate_changes(change)
    end

    def message
      if paid == total
        'Payment completed'
      elsif paid > total
        'Payment completed. Get your change!'
      else
        'Insufficient money. Insert more, please.'
      end
    end
  end
end
