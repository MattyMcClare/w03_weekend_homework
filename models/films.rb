require_relative('../db/sql_runner.rb')
require_relative('./customers.rb')
require_relative('./tickets.rb')

class Film
  attr_reader :id
  attr_accessor :title, :price
  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price'].to_i
  end


  def ticket_price
    sql = 'SELECT * FROM films
    WHERE id = $1'
    values = [@id]
    film_price_hash = SqlRunner.run(sql, values).first
    ticket_price = Film.new(film_price_hash).price
    return ticket_price
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
