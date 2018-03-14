module Cleo
  class Product
    attr_accessor :name, :price, :quantity

    def initialize(params)
      @name = params[:name]
      @price = params[:price]
      @quantity = params[:quantity]
    end
  end
end
