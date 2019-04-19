require_relative ('../db/sql_runner.rb')


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

   def update()
     sql = "UPDATE films SET (title, price) = ($1,$2) WHERE id = $3;"
     values = [@title, @price, @id]
     SqlRunner.run(sql, values)
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




end
