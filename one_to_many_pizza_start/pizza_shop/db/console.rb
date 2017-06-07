require "pry-byebug"
require_relative "../models/pizza_order"
require_relative "../models/customer"

PizzaOrder.delete_all()
Customer.delete_all()

customer1 = Customer.new({"name" => "Glen"})

customer2 = Customer.new({"name" => "filipe"})

customer3 = Customer.new({"name" => "Fin"})

customer1.save()
customer2.save()
customer3.save()

order1 = PizzaOrder.new({
  'customer_id' => customer1.id,
  'topping' => 'pepperoni & pineapple',
  'quantity' => 4
  })
order2 = PizzaOrder.new({
  'customer_id' => customer2.id,
  'topping' => 'Ancovies',
  'quantity' => 2
  })
order3 = PizzaOrder.new({
  'customer_id' => customer3.id,
  'topping' => 'pepperoni & chilies',
  'quantity' => 1
  })

order1.save()
order2.save()
order3.save()

binding.pry
nil
