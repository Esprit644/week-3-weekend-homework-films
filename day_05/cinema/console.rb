require ('pry')


require_relative ('models/customer.rb')
require_relative ('models/film.rb')
require_relative ('models/ticket.rb')

Customer.delete_all()
Film.delete_all()
Ticket.delete_all()

customer1 = Customer.new({'name' => 'John Smith', 'funds' => '10'})
customer2 = Customer.new({'name' => 'Bob Duncan', 'funds' => '20'})
customer3 = Customer.new({'name' => 'Rod White', 'funds' => '30'})
customer4 = Customer.new({'name' => 'Paul Jones', 'funds' => '40'})

film1 = Film.new({'title' => 'Kellys Heroes', 'price' => '1'})
film2 = Film.new({'title' => 'Blues Brothers', 'price' => '2'})
film3 = Film.new({'title' => 'Matrix', 'price' => '3'})
film4 = Film.new({'title' => 'Dr No', 'price' => '4'})



customer1.save()
customer2.save()
customer3.save()
customer4.save()

film1.save()
film2.save()
film3.save()
film4.save()

ticket1 = Ticket.new({'cust_id' => customer1.id, 'film_id' => film1.id})
ticket2 = Ticket.new({'cust_id' => customer2.id, 'film_id' => film1.id})
ticket3 = Ticket.new({'cust_id' => customer3.id, 'film_id' => film2.id})
ticket4 = Ticket.new({'cust_id' => customer3.id, 'film_id' => film3.id})
ticket5 = Ticket.new({'cust_id' => customer3.id, 'film_id' => film4.id})
ticket6 = Ticket.new({'cust_id' => customer4.id, 'film_id' => film1.id})

ticket1.save()
ticket2.save()
ticket3.save()
ticket4.save()
ticket5.save()
ticket6.save()

Film.show_all()
Ticket.show_all()
Customer.show_all()

# film1.title = "Kellys Losers"
# film1.update()

customer1.name = "Janice Smith"
customer1.update()

customer3.find_films()
film1.find_customers_at_film()

#customer4.delete_customer()

#film4.delete_film()
price = film3.get_ticket_price()
 customer2.reduce_customer_funds(price)
p customer2.funds -= price
#customer2.update()

customer3.ticket_count_by_cust()
film1.ticket_count_by_film()

film1.customer_names_going_to_film()
