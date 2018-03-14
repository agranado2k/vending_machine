module Cleo
  class Purchase
    attr_accessor :product, :paid, :change, :change_list

    def initialize(params)
      @product = params[:product]
      @paid = 0
      @change = 0
      @change_list = []
    end

    def total
      product.price
    end

    def balance
      paid - total
    end
  end
end
