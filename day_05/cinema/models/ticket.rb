require_relative ('../db/sql_runner.rb')
require_relative ('./customer.rb')
require_relative ('./film.rb')

class Ticket

  attr_reader :id, :cust_id, :film_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @cust_id = options['cust_id'].to_i
    @film_id = options['film_id'].to_i
  end

  def save()

    sql = " INSERT INTO tickets(
    cust_id,
    film_id
    )
    VALUES
    ($1,
     $2)
     RETURNING id;"
     values = [@cust_id, @film_id]

     results = SqlRunner.run(sql, values)
     @id = results.first['id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end

  def self.show_all()
    sql = "SELECT * FROM tickets"
    results = SqlRunner.run(sql)
     results.map{|each_ticket|Ticket.new(each_ticket)}
  end
end
