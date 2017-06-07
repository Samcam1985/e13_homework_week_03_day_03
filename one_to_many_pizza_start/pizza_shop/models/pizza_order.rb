require('pg')
require_relative "../db/sql_runner"
require_relative "customer"

class PizzaOrder

  attr_accessor :topping, :quantity, :customer_id
  attr_reader :id

  def initialize(options)
    @topping = options['topping']
    @quantity = options['quantity'].to_i
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id'].to_i
  end

  def save()
    sql = "
    INSERT INTO pizza_orders (
      customer_id,
      topping,
      quantity
    ) VALUES (
      #{@customer_id},
      '#{@topping}',
      #{@quantity}
    )
    RETURNING id;"
    @id = SqlRunner.run(sql)[0]["id"].to_i
  end

  def update()
    sql = "
    UPDATE pizza_orders SET (
      customer_id,
      topping,
      quantity
    ) = (
      #{@customer_id},
      '#{ @topping }',
      #{ @quantity }
    )
    WHERE id = #{@id}"
    orders = SqlRunner.run(sql)
    return orders.map{|order| PizzaOrder.new(order)}
  end

  def delete()
    sql = "DELETE FROM pizza_orders where id = #{@id}"
    orders = SqlRunner.run(sql)
    return orders.map{|order| PizzaOrder.new(order)}
  end

  def self.find(id)
    sql = "SELECT * FROM pizza_orders WHERE id = #{id}"
    results = SqlRunner.run(sql)
    order_hash = results.first
    return results.map{|result| PizzaOrder.new(order_hash)}
  end

  def self.delete_all()
    sql = "DELETE FROM pizza_orders"
    orders = SqlRunner.run(sql)
    return orders.map{|order| PizzaOrder.new(order)}
  end

  def self.all()
    sql = "SELECT * FROM pizza_orders;"
    orders = SqlRunner.run(sql)
    return orders.map{|order| PizzaOrder.new(order)}
  end

  def customer()
    sql = "SELECT * FROM customers WHERE id = #{@customer_id}"
    results = SqlRunner.run(sql)
    customer_data = results[0]
    customer = Customer.new(customer_data)
    return customer
  end

end
