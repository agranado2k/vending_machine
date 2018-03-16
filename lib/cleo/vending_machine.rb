module Cleo
  class VendingMachine
    attr_accessor :products, :changes

    def init
      @products = Cleo::Product.load
      @changes = Cleo::Change.load
    end
  end
end
