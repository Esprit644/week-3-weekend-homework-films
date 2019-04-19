require_relative ('../db/sql_runner.rb')
require_relative('./film.rb')


class Customer

  attr_reader  :id
  attr_accessor :name, :funds

  def initialize(options)
    @name = options['name']
    @funds = options['funds'].to_i
    @id = options['id'].to_i if options['id']
  end

  def save()
    sql = "INSERT INTO customers (
    name,
    funds
    )
    VALUES (
      $1,
      $2)
    RETURNING id;"
    values = [@name, @funds]
    results = SqlRunner.run(sql, values)
    @id = results.first['id'].to_i
  end

  def find_films()
    sql = "SELECT films.* FROM films
          INNER JOIN tickets
          ON films.id = tickets.film_id
          INNER JOIN customers
          ON tickets.cust_id = customers.id
          WHERE customers.id = $1;"

      values = [@id]
      results = SqlRunner.run(sql,values)
      p results.map{|each_film| Film.new(each_film)}

  end

  def update()
    sql = "UPDATE customers SET (name, funds) = ($1, $2) WHERE id = $3;"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM customers;"
    SqlRunner.run(sql)
  end

  def self.show_all()
    sql = "SELECT * FROM customers"
    results = SqlRunner.run(sql)
     results.map{|each_customer|Customer.new(each_customer)}
  end


end
