require 'yaml'
require 'json'
require 'money'

require_relative 'cleo/hash'
require_relative 'cleo/loadable'
require_relative 'cleo/change'
require_relative 'cleo/product'
require_relative 'cleo/change_calculator'
require_relative 'cleo/purchase'
require_relative 'cleo/user_interface'
require_relative 'cleo/io_interface'
require_relative 'cleo/vending_machine'

module Cleo
  CURRENCY = 'GBP'
  I18n.enforce_available_locales = false

  def self.run_vending_machine
    Cleo::VendingMachine.execute
  end
end

