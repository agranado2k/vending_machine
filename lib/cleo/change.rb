module Cleo
  class Change
    extend Loadable

    attr_accessor :name, :quantity, :value

    def initialize(params)
      @name = params[:name]
      @quantity = params[:quantity]
      @value = Money.new(params[:value], CURRENCY)
    end

    def cents
      @value.cents
    end
  end
end
