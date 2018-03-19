module Cleo
  class Change
    extend Loadable

    attr_accessor :name, :value, :quantity

    def initialize(params)
      @name = params[:name]
      @value = params[:value]
      @quantity = params[:quantity]
    end
  end
end
