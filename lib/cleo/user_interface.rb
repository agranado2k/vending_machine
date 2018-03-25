module Cleo
  class UserInterface
    def template_index(products, changes, product_error)
      output = header(changes)
      output += select_product_by_code
      output += product_table(products, false)
      output += invalide_product_code if product_error
      output += choose_product
    end

    def template_checkout(purchase, changes, invalid_money = false)
      output = header(changes)
      output += you_are_bying
      output += product_table([purchase.product], true)
      output += checkout(purchase)
      output += invalid_money_id if invalid_money
      output += checkout_footer(purchase)
      output
    end


    def header(changes)
      <<~EOT
      #############################################
      ############ Vending Machine ################
      #############################################
      Changes: [#{changes.map{|c| "#{c.quantity}x#{c.name}"}.reverse.join(',')}]
      (press r any time to reload system)

      EOT
    end

    def product_table(products, purchasing)
      rows = products.map{|p| product_line(p, purchasing)}.join("\n--------------------------------------\n")
      <<~EOT
      code |  product  | price#{ !purchasing ? " | quantity" : ""}
      --------------------------------------
      #{rows}

      EOT
    end

    def product_line(p, purchasing)
      "  #{p.code}  | #{p.name} | #{p.price}#{ !purchasing ? " | #{p.quantity}" : "" }"
    end

    def checkout(purchase)
      output = <<~EOT
      Checkout:
      total: #{purchase.total.format}
      paid: #{purchase.paid.format}
      balance: #{purchase.balance.format}
      due change: #{purchase.change.format}

      EOT
      output += checkout_alert(purchase)
      output += changes(purchase)
    end

    def checkout_alert(purchase)
      if purchase.paid > 0
        "** #{purchase.message if purchase.paid > 0} **\n\n"
      else
        ""
      end
    end

    def choose_product
      "Insert product code:\n"
    end

    def select_product_by_code
      "*** Plese Select one Product by code***\n"
    end
    def you_are_bying
      "*** You're buying the product:***\n"
    end

    def invalide_product_code
      "** Invalid product code **\n\n"
    end

    def invalid_money_id
      "** Invalid money **\n\n"
    end

    def checkout_footer(purchase)
      if purchase.paid >= purchase.total
        keep_buying
      else
        insert_follow_values
      end
    end

    def changes(purchase)
      if purchase.paid > purchase.total
        "(changes: #{purchase.changes.join(", ")})\n\n"
      else
        ""
      end
    end

    def keep_buying
      "(press c to keep bying)\n"
    end

    def insert_follow_values
      "Insert one of the follow valeus\n(1p, 2p ,5p, 10p, 20p, 50p, £1, £2)\n"
    end
  end
end
