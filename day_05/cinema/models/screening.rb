require('pry')
require_relative('./film.rb')
require_relative('./ticket.rb')

class Screening

attr_reader :id, :screenings, :film_id

def initialize(options)
  @id = options['id'].to_i if options['id']
  @screenings = options['screenings'].to_i
  @film_id = options['film_id']
end

def save_screening()
  sql = "INSERT INTO screenings (screenings, film_id) VALUES ($1, $2)
  RETURNING id"
  values = [@screenings, @film_id]
  x = SqlRunner.run(sql,values)
  @id = x[0]['id'].to_i
end

end
