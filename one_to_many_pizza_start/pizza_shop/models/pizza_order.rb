require('pg')

class PizzaOrder

  attr_accessor :first_name, :last_name, :topping, :quantity
  attr_reader :id

  def initialize(options)
    @first_name = options['first_name']
    @last_name = options['last_name']
    @topping = options['topping']
    @quantity = options['quantity'].to_i
    @id = options['id'].to_i if options['id']
  end

  def save()
    db = PG.connect({ dbname: 'pizza_shop', host: 'localhost' })
    sql = "
    INSERT INTO pizza_orders (
      first_name,
      last_name,
      topping,
      quantity
    ) VALUES (
      '#{ @first_name }',
      '#{ @last_name }',
      '#{ @topping }',
      #{ @quantity }
    )
    RETURNING id;"
    @id = db.exec(sql)[0]["id"].to_i
    db.close()
  end

  def update()
    db = PG.connect({ dbname: 'pizza_shop', host: 'localhost' })
    sql = "
    UPDATE pizza_orders SET (
      first_name,
      last_name,
      topping,
      quantity
    ) = (
      '#{@first_name}',
      '#{@last_name}',
      '#{@topping}',
      #{@quantity} )
    WHERE id = #{@id}"
    db.exec(sql)
    db.close()
  end

  def delete()
    db = PG.connect({ dbname: 'pizza_shop', host: 'localhost' })
    sql = "DELETE FROM pizza_orders where id = #{@id}"
    db.exec(sql)
    db.close()
  end

  def self.find(id)
    db = PG.connect({ dbname: 'pizza_shop', host: 'localhost' })
    sql = "SELECT * FROM pizza_orders WHERE id = #{id}"
    results = db.exec(sql)
    db.close()
    order_hash = results.first
    order = PizzaOrder.new(order_hash)
    return order
  end

  def self.delete_all()
     db = PG.connect({ dbname: 'pizza_shop', host: 'localhost' })
    sql = "DELETE FROM pizza_orders"
    db.exec(sql)
    db.close()
  end

  def self.all()
    db = PG.connect({ dbname: 'pizza_shop', host: 'localhost' })
    sql = "SELECT * FROM pizza_orders;"
    orders = db.exec(sql)
    db.close()
    return orders.map { |order| PizzaOrder.new(order) }
  end

end
