require('pry')
require_relative ('../db/sql_runner.rb')
require_relative ('./customer.rb')
require_relative ('./ticket.rb')


class Film

  attr_reader :id
  attr_accessor  :title, :price

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price'].to_i
  end

  def save()

    sql = "INSERT INTO films
    (title,
     price)
     VALUES(
       $1,
       $2
     )
     RETURNING id;"

     values = [@title, @price]
     results = SqlRunner.run(sql, values)
     @id = results.first['id'].to_i
   end

   def find_customers_at_film()
     sql = "SELECT customers.* FROM customers
            INNER JOIN tickets
            ON customers.id = tickets.cust_id
            INNER JOIN films
            ON tickets.film_id = films.id
            WHERE films.id = $1;"

      values = [@id]
      results = SqlRunner.run(sql, values)
      p results.map{|each_customer|Customer.new(each_customer)}
   end

   #

   def update()
     sql = "UPDATE films SET (title, price) = ($1,$2) WHERE id = $3;"
     values = [@title, @price, @id]
     SqlRunner.run(sql, values)
   end

   def delete_film()
     sql = "DELETE FROM films WHERE id = $1;"
     values = [@id]
     SqlRunner.run(sql,values)
   end

   def self.delete_all()
     sql = "DELETE FROM films"
     SqlRunner.run(sql)
  end

  def self.show_all()
    sql = "SELECT * FROM films;"
    results = SqlRunner.run(sql)
    results.map{|each_film|Film.new(each_film)}
  end

  def get_ticket_price()
    sql = "SELECT films.price FROM films WHERE films.id = $1;"
    values = [@id]
    ticket_price = SqlRunner.run(sql,values)
    p cost = ticket_price.first['price'].to_i

  end

    # def ticket_count_by_film()
    #   sql = "SELECT tickets.id FROM tickets
    #           INNER JOIN films
    #           ON  tickets.film_id = films.id
    #           WHERE films.title = $1"
    #
    #   values = [@title]
    #   results = SqlRunner.run(sql, values)
    #   ticket_count = results.count
    #   p ticket_count
    # end


    def ticket_count_by_film()
      sql = "SELECT tickets.id FROM tickets

              WHERE film_id = $1"
    
      values = [@id]
      results = SqlRunner.run(sql, values)
      ticket_count = results.count
      p ticket_count
    end

    def customer_names_going_to_film()
      sql = "SELECT customers.name FROM customers
            INNER JOIN tickets
            ON customers.id = tickets.cust_id
            INNER JOIN films
            ON films.id = tickets.film_id
              WHERE films.title = $1;"

      values = [@title]
      results = SqlRunner.run(sql, values)
      name_list = results.map{|name|Customer.new(name)}
      name_list.each{|each_cust| puts each_cust.name}
    end

end
