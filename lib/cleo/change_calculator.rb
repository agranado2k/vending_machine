module Cleo
  class ChangeCalculator
    attr_reader :changes

    def initialize(changes)
      @changes = changes
    end

    def calculate_changes(value)
      due_changes = Hash.new(0)
      while value > 0 do
        change = changes.select {|k, c| value.cents >= k && c.quantity > 0}.values.last
        change.quantity -= 1
        value -= change.value
        due_changes[change.name] += 1
      end
      due_changes.map{|tag, qtd| "#{qtd}x#{tag}"}
    end

  end
end
