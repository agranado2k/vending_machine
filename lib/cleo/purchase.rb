module Cleo
  class Purchase
    attr_accessor :product, :money

    def initialize(params)
      @product = params[:product]
      @money = []
    end

    def total
      product.price
    end

    def balance
      paid - total
    end

    def insert(money)
      @money << money
    end

    def paid
      money.reduce(0){|r, m| r += m.value}
    end

    def change
      return 0 if paid <= total
      paid - total
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
