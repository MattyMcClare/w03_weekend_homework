require_relative('../db/sql_runner.rb')
require_relative('./films.rb')
require_relative('./tickets.rb')

class Customer
  attr_reader :id
  attr_accessor :name, :funds
  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds'].to_i
  end

  def number_of_tickets_bought_by_customer
    return screenings.length
  end

  def buy_ticket(film_obj)
    return @funds - film_obj.ticket_price
  end

  def screenings
    sql = 'SELECT screenings.*
    FROM screenings
    INNER JOIN tickets
    ON tickets.screening_id = screenings.id
    WHERE customer_id = $1'
    values = [@id]
    films = SqlRunner.run(sql, values)
    return films.map { |film| Screening.new(film) }
  end

  def save
    sql = 'INSERT INTO customers (name, funds)
      VALUES ($1, $2)
      RETURNING id'
    values = [@name, @funds]
    customer = SqlRunner.run(sql, values).first
    @id = customer['id'].to_i
  end

  def update
    sql = 'UPDATE customers
    SET name = $1
    WHERE id = $2'
    values = [@name, @id]
    SqlRunner.run(sql, values)
  end

  def delete
    sql = 'DELETE FROM customers
    WHERE id = $1'
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all
    sql = 'DELETE FROM customers'
    SqlRunner.run(sql)
  end

  def self.all
      sql = 'SELECT * FROM customers'
      customers_all = SqlRunner.run(sql)
      return customers_all.map { |customer| Customer.new(customer) }
  end
end
