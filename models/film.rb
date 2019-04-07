require_relative('../db/sqlrunner.rb')

class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price'].to_i
  end

  def save()
    sql = "INSERT INTO films (title, price) VALUES ($1, $2) RETURNING id"
    values = [@title, @price]
    film = SqlRunner.run(sql, values)[0]
    @id = film['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM films"
    films = SqlRunner.run(sql)
    return films.map {|films| Film.new(films)}
  end

  def self.delete_all()
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM films WHERE id = $1"
    value = [@id]
    SqlRunner.run(sql, value)
  end

  def films()
    sql = "SELECT FROM films WHERE id = $1"
    value = [@id]
    SqlRunner.run(sql, value)
  end

  def update()
    sql = "UPDATE films SET (title, price) = ($1, $2) WHERE id = $3"
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

  def customers() # in films or custommers? getting back the films
    sql = "SELECT films.* FROM films INNER JOIN tickets ON films.id = tickets.film_id WHERE tickets.customer_id = $1"
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results.map {|films| Film.new(film)}
  end


end
