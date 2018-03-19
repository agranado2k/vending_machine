module Cleo
  class Product
    extend Loadable

    attr_accessor :name, :price, :quantity

    def initialize(params)
      @name = params[:name]
      @price = params[:price]
      @quantity = params[:quantity]
    end
  end
end
