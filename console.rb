require_relative('models/customers.rb')
require_relative('models/films.rb')
require_relative('models/tickets.rb')
require_relative('models/screenings.rb')

require('pry')

Ticket.delete_all
Screening.delete_all
Customer.delete_all
Film.delete_all

customer1 = Customer.new({
  'name' => 'Bob',
  'funds'=> 100
  })
customer1.save

customer2 = Customer.new({
  'name' => 'Billy',
  'funds'=> 80
  })
customer2.save

customer3 = Customer.new({
  'name' => 'Joe',
  'funds'=> 30
  })
customer3.save

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

screening1 = Screening.new({
  'film_id' => film1.id,
  'screening_time' => '19:00'
  })
screening1.save

screening2 = Screening.new({
  'film_id' => film2.id,
  'screening_time' => '12:00'
  })
screening2.save

ticket1 = Ticket.new({
  'customer_id' => customer1.id,
  'screening_id' => screening1.id
  })
ticket1.save

ticket2 = Ticket.new({
  'customer_id' => customer1.id,
  'screening_id' => screening2.id
  })
ticket2.save

ticket3 = Ticket.new({
  'customer_id' => customer2.id,
  'screening_id' => screening2.id
  })
ticket3.save

ticket4 = Ticket.new({
  'customer_id' => customer3.id,
  'screening_id' => screening2.id
  })
ticket4.save



# customer1.name = 'George'
# customer1.update
#
# film1.price = 15
# film1.update
#
# ticket1.film_id = film2.id
# ticket1.update
#
binding.pry
nil
