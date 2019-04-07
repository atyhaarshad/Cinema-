require_relative('../db/sqlrunner.rb')

class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds'].to_i
  end

  def save()
    sql = "INSERT INTO customers (name, funds) VALUES ($1, $2) RETURNING id"
    values = [@name, @funds]
    customer = SqlRunner.run(sql, values)[0]
    @id = customer['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM customers"
    customers = SqlRunner.run(sql)
    return customers.map {|customer| Customer.new(customer)}
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM customers WHERE id = $1"
    value = [@id]
    SqlRunner.run(sql, value)
  end

  def update()
    sql = "UPDATE customers SET (name, funds) = ($1, $2) WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def tickets() # sql statemnt shows how many tickets a customer has
    sql = "SELECT customers.* FROM customers INNER JOIN tickets ON customers.id = tickets.customer_id WHERE tickets.customer_id = $1"
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results.map { |customer| Customer.new(customer)}
  end

  def films_to_watch() # shows films that customers going to see
    sql = "SELECT customers.name AS customer_name, films.title AS film_booked_to_see FROM customers INNER JOIN tickets ON tickets.customer_id = customers.id INNER JOIN films ON films.id = tickets.film_id WHERE tickets.customer_id = $1"
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results.map { |film| Film.new(film)}
  end

  def buy_ticket(film_price)
    @funds -= film_price
  end

end
