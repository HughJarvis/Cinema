require_relative("../db/sql_runner")
require_relative("film.rb")
require_relative("ticket.rb")

class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds'].to_i
  end

  def save()
    sql = "INSERT INTO customers (name, funds)
        VALUES ($1, $2) RETURNING id"
    values = [@name, @price]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def Customer.all()
    sql = "SELECT * FROM customers"
    results = SqlRunner.run(sql)
    return results.map{ |customer| Customer.new(customer)}
  end

  def Customer.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

  def films()
    sql = "SELECT films.* FROM films INNER JOIN
          tickets ON tickets.film_id = films.id
          WHERE tickets.customer_id = $1"
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results.map{ |film| Film.new(film) }
  end

  def tickets()
    sql= "SELECT tickets.* FROM tickets INNER JOIN
          customers ON customers.id = tickets.customer_id
          WHERE customers.id = $1"
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results.map{ |ticket| Ticket.new(ticket) }
  end


  def buy_ticket(film)
    @funds -= film.price
    #return Ticket.new({'customer_id' => @id, 'film_id' => film.id})
  end
end