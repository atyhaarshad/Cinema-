require_relative('models/customer.rb')
require_relative('models/film.rb')
require_relative('models/ticket.rb')
require('pry-byebug')

Customer.delete_all()
Film.delete_all()
Ticket.delete_all()

customer1 = Customer.new({'name' => 'Gal', 'funds' => '20'})
customer1.save()
customer2 = Customer.new({'name' => 'Jason', 'funds' => '50'})
customer2.save()
customer3 = Customer.new({'name' => 'Henry', 'funds' => '25'})
customer3.save()


film1 = Film.new({'title' => 'Shazam!', 'price' => '10'})
film1.save()
film2 = Film.new({'title' => 'Aquaman', 'price' => '5'})
film2.save()

ticket1 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film1.id})
ticket1.save()
ticket2 = Ticket.new({'customer_id' => customer2.id, 'film_id' => film1.id})
ticket2.save()
ticket3 = Ticket.new({'customer_id' => customer2.id, 'film_id' => film2.id})
ticket3.save()
ticket4 = Ticket.new({'customer_id' => customer3.id, 'film_id' => film1.id})
ticket4.save()

binding.pry()

nil
