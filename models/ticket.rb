require_relative("../db/sql_runner")
require_relative("customer.rb")
require_relative("film.rb")
require_relative("screening.rb")

class Ticket

  attr_reader :id
  attr_accessor :customer_id, :film_id, :screening_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id'].to_i
    @film_id = options['film_id'].to_i
    @screening_id = options['screening_id'].to_i
  end

  def save()
    sql = "INSERT INTO tickets (customer_id, film_id, screening_id)
          VALUES ($1, $2, $3) RETURNING id"
    values = [@customer_id, @film_id, @screening_id]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def Ticket.all()
    sql = "SELECT * FROM tickets"
    results = SqlRunner.run(sql)
    return results.map{ |ticket| Ticket.new(ticket) }
  end

  def Ticket.delete_all()
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end

  def update()
    sql = "UPDATE tickets SET (customer_id, film_id, screening_id)
          = ($1, $2, $3) WHERE id = $4"
    values = [@customer_id, @film_id, @screening_id, @id]
    SqlRunner.run(sql, values)
  end
end
