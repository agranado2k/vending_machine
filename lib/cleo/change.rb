module Cleo
  class Change < Money
    extend Loadable

    attr_accessor :quantity

    def initialize(params)
      super(params)
      @quantity = params[:quantity]
    end
  end
end
