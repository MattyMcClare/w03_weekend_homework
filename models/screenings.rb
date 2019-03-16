require_relative('../db/sql_runner.rb')
require_relative('./tickets.rb')
require_relative('./films.rb')

class Screening
  attr_reader :id
  attr_accessor :ticket_id, :film_id, :screening_time
  def initialize(options)
    @id = options['id'].to_i if options['id']
    @film_id = options['film_id'].to_i
    @screening_time = options['screening_time']
  end

  def self.most_popular_screening_time
    sql = 'SELECT screening_time FROM screenings
    WHERE id = $1'
    values = [Ticket.most_popular_screening()]
    time = SqlRunner.run(sql, values).first
    return time['screening_time']
  end

  def save
    sql = 'INSERT INTO screenings (film_id, screening_time)
    VALUES ($1, $2)
    RETURNING id'
    values = [@film_id, @screening_time]
    screening = SqlRunner.run(sql, values).first
    @id = screening['id'].to_i
  end

  def number_of_customers_at_screening
    return customers.length
  end

  def customers
    sql = 'SELECT customers.*
    FROM customers
    INNER JOIN tickets
    ON tickets.customer_id = customers.id
    WHERE screening_id = $1'
    values = [@id]
    customers = SqlRunner.run(sql, values)
    return customers.map { |customer| Customer.new(customer) }
  end

  def self.delete_all
    sql = 'DELETE FROM screenings'
    SqlRunner.run(sql)
  end
end
