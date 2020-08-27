require_relative './part_1_solution.rb'
require 'pry'

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  # 1. iterate through coupons and assign each hash to 'discount_item'
  #   2. iterate through cart and assign each hash to 'item'
  #     3. if discount_item[:item] == item[:item]
  #       4. count = 0
  #         5. if item[:count] == discount_item[:num]
  #           6. new hash with item name + "W/COUPON", discounted price, clearance,
  #             and the correct count of discounted items and assign discounted
  #           7. item[:count] -= discount_item[:num]
  #           8. add discounted to cart
  #         9. if item[:count] > discount_item[:num]
  #           10. while item count is >= discounted item num
  #             11. item count -= discounted item num
  #             12. add discounted item num to count
  #           13. new hash with item name + "W/COUPON", discounted price, clearance,
  #             and the correct count of discounted items and assign discounted
  #           14. add discounted to cart
  # 15. return cart
  cart.each do |item|
    coupons.each do |discount_item|
      if discount_item[:item] == item[:item]
        count = 0
        if item[:count] == discount_item[:num]
          discounted = {item: item[:item] + " W/COUPON", price: discount_item[:cost] / discount_item[:num],\
                          clearance: item[:clearance], count: item[:count]}
          item[:count] -= discount_item[:num]
          cart << discounted
        end
        if item[:count] > discount_item[:num]
          while (item[:count] >= discount_item[:num]) do
            item[:count] -= discount_item[:num]
            count += discount_item[:num]
          end
          discounted = {item: item[:item] + " W/COUPON", price: discount_item[:cost]/discount_item[:num],\
                        clearance: item[:clearance], count: count}
          cart << discounted
        end
      end
    end
  end
  cart
end


def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  cart.each do |item|
    if item[:clearance]
      item[:price] -= (item[:price] * 0.20)
    end
  end
  cart
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
  total = 0
  consolidated = consolidate_cart(cart)
  consolidated_wc = apply_coupons(consolidated, coupons)
  consolidated_wc_and_clearance = apply_clearance(consolidated_wc)
  consolidated_wc_and_clearance.each do |item|
    item_total = item[:price] * item[:count]
    total += item_total
  end
  if total > 100
    total -= total * 0.10
  end
  total
end
