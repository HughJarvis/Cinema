require_relative("../db/sql_runner")
require_relative("customer.rb")
require_relative("film.rb")
require_relative("ticket.rb")

class Screening

  attr_reader :id
  attr_accessor :film_id, :start_time, :seats_available, :seats_sold

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @film_id = options['film_id']
    @start_time = options['start_time']
    @seats_available = options['seats_available'].to_i
    @seats_sold = options['seats_sold'].to_i
  end

  def save()
    sql = "INSERT INTO screenings (film_id, start_time, seats_available, seats_sold)
          VALUES ($1, $2, $3, $4) RETURNING id"
    values = [@film_id, @start_time, @seats_available, @seats_sold]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def Screening.all()
    sql = "SELECT * FROM screenings"
    results = SqlRunner.run(sql)
    return results.map{ |screening| Screening.new(screening) }
  end

  def Screening.delete_all()
    sql = "DELETE FROM screenings"
    SqlRunner.run(sql)
  end

  def update()
    sql = "UPDATE screenings SET (film_id, start_time, seats_available, seats_sold)
          = ($1, $2, $3, $4) WHERE id = $5"
    values = [@film_id, @start_time, @seats_available, @seats_sold, @id]
    SqlRunner.run(sql, values)
  end

  def find_price()
    sql = "SELECT films.price FROM films INNER JOIN screenings ON screenings.film_id = films.id WHERE screenings.id = $1"
    values = [@id]
    return SqlRunner.run(sql, values)[0]['price'].to_i
  end

  def Screening.best_seller
    # use ORDER BY to sort SQL stuff"
    sql = "SELECT * FROM screenings ORDER BY seats_sold DESC"
    return SqlRunner.run(sql)[0]
  end


end
