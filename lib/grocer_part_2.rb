require_relative './part_1_solution.rb'

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
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
