require_relative './part_1_solution.rb'

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  
  coupons.each do |coupon|
    coupon_item = find_item_by_name_in_collection(coupon[:item], cart)
    if coupon_item[:count] >= coupon[:num]
      cart << { item: "#{coupon_item[:item]} W/COUPON", 
                price: coupon[:cost] / coupon[:num], 
                clearance: coupon_item[:clearance],
                count: coupon[:num]
              }
      coupon_item[:count] -= coupon[:num]
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
      new_price = item[:price] *= 0.8
      new_price.round(2)
    end
    item
  end
  
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
  
  checkout_cart = apply_clearance(apply_coupons(consolidate_cart(cart), coupons))
  
  checkout_cart.each { |item| total += item[:price] * item[:count] }
  
  total > 100 ? total *= 0.9 : total.round(2)
  
end
