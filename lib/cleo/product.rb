module Cleo
  class Product
    extend Loadable

    attr_accessor :code, :name, :value, :quantity

    def initialize(params)
      @code = params[:code]
      @name = params[:name]
      @value = Money.new(params[:value]*100, CURRENCY)
      @quantity = params[:quantity]
    end

    def price
      value.format
    end
  end
end
