require_relative('../db/sql_runner.rb')

class Film
  attr_reader :id
  attr_accessor :title, :price
  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price'].to_i
  end

  def customers
    sql = 'SELECT customers.*
    FROM customers
    INNER JOIN tickets
    ON tickets.customer_id = customers.id
    WHERE film_id = $1'
    values = [@id]
    customers = SqlRunner.run(sql, values)
    return customers.map { |customer| Customer.new(customer) }
  end

  def save
    sql = 'INSERT INTO films (title, price)
      VALUES ($1, $2)
      RETURNING id'
    values = [@title, @price]
    film = SqlRunner.run(sql, values).first
    @id = film['id'].to_i
  end

  def update
    sql = 'UPDATE films
    SET price = $1
    WHERE id = $2'
    values = [@price, @id]
    SqlRunner.run(sql, values)
  end

  def delete
    sql = 'DELETE FROM films
    WHERE id = $1'
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all
    sql = 'DELETE FROM films'
    SqlRunner.run(sql)
  end

  def self.all
    sql = 'SELECT * FROM films'
    films_all = SqlRunner.run(sql)
    return films_all.map { |film| Film.new(film) }
  end
end
