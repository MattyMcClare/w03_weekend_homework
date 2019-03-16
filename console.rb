require_relative('models/customers.rb')
require_relative('models/films.rb')
require_relative('models/tickets.rb')

require('pry')

# Ticket.delete_all
# Customer.delete_all
# Film.delete_all

customer1 = Customer.new({
  'name' => 'Bob',
  'funds'=> 100
  })
customer1.save

film1 = Film.new({
  'title' => 'Avangers',
  'price' => 10
  })
film1.save

film2 = Film.new({
  'title' => 'Titanic',
  'price' => 12
  })
film2.save

ticket1 = Ticket.new({
  'customer_id' => customer1.id,
  'film_id' => film1.id
  })
ticket1.save

customer1.name = 'George'
customer1.update

film1.price = 15
film1.update

ticket1.film_id = film2.id
ticket1.update

binding.pry
nil
