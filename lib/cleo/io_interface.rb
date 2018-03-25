module Cleo
  class IOInterface
    def input
      gets.chomp
    end

    def output(m)
      system 'clear'
      puts m
    end
  end
end
