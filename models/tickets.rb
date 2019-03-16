require_relative('../db/sql_runner.rb')

class Ticket
  attr_reader :id
  attr_accessor :customer_id, :film_id
  def initialize(options)
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id'].to_i
    @film_id = options['film_id'].to_i
  end

  def save
    sql = 'INSERT INTO tickets (customer_id, film_id)
      VALUES ($1, $2)
      RETURNING id'
    values = [@customer_id, @film_id]
    ticket = SqlRunner.run(sql, values).first
    @id = ticket['id'].to_i
  end

  def update
    sql = 'UPDATE tickets
    SET film_id = $1
    WHERE customer_id = $2'
    values = [@film_id, @id]
  end

  def delete
    sql = 'DELETE FROM tickets
    WHERE id = $1'
    values = [@id]
    SqlRunner.run(sq)
  end

  def self.delete_all
    sql = 'DELETE FROM tickets'
    SqlRunner.run(sql)
  end

  def self.all
    sql = 'SELECT * FROM tickets'
    tickets_all = SqlRunner.run(sql)
    return tickets_all.map { |ticket| Ticket.new(ticket) }
  end
end
