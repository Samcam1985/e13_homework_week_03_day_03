require "pg"
require_relative "../db/sql_runner"
require_relative "pizza_order"


class Customer
  attr_reader :id, :name

  def initialize(options)
      @id = options["id"].to_i
      @name = options["name"]
  end

  def save()
    sql = "INSERT INTO customers
    (
    name
    )
    VALUES
    (
    '#{@name}'
    )
    RETURNING id"
    @id = SqlRunner.run(sql)[0]["id"].to_i
  end

  def Customer.delete_all()
    sql = "DELETE FROM customers"
    customers = SqlRunner.run(sql)
    return customers.map{|customer| Customer.new(customer)}
  end

  def Customer.all()
      sql = "SELECT * FROM customers"
      customers = SqlRunner.run(sql)
      return customers.map{|customer| Customer.new(customer)}
  end

  def pizza_orders()
    sql = "SELECT * FROM pizza_orders WHERE customer_id = #{id}"
    results = SqlRunner.run(sql)
    orders = results.map {|order| PizzaOrder.new(order)}
    return orders
  end
end
