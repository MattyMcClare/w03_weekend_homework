require_relative('../db/sql_runner.rb')
require_relative('./screenings.rb')
require_relative('./customers.rb')

class Ticket
  attr_reader :id
  attr_accessor :customer_id, :screening_id
  def initialize(options)
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id'].to_i
    @screening_id = options['screening_id'].to_i
  end

  def save
    sql = 'INSERT INTO tickets (customer_id, screening_id)
      VALUES ($1, $2)
      RETURNING id'
    values = [@customer_id, @screening_id]
    ticket = SqlRunner.run(sql, values).first
    @id = ticket['id'].to_i
  end

  def update
    sql = 'UPDATE tickets
    SET screening_id = $1
    WHERE customer_id = $2'
    values = [@screening_id, @id]
  end

  def delete
    sql = 'DELETE FROM tickets
    WHERE id = $1'
    values = [@id]
    SqlRunner.run(sql)
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

  def self.most_popular_screening
    screening_arr = Ticket.all.map { |screening| screening.screening_id }
    most_frequent_item = screening_arr.uniq.max_by do
      |screening| screening_arr.count( screening )
    end
    return most_frequent_item
  end
end
