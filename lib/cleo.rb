require 'yaml'
require 'json'
require 'money'

require 'cleo/hash'
require 'cleo/loadable'
require 'cleo/change'
require 'cleo/product'
require 'cleo/change_calculator'
require 'cleo/purchase'
require 'cleo/user_interface'
require 'cleo/vending_machine'

module Cleo
  CURRENCY = 'GBP'
  I18n.enforce_available_locales = false
end
