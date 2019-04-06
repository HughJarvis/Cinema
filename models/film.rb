require_relative("../db/sql_runner")
require_relative("customer.rb")
require_relative("ticket.rb")

class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price'].to_i
  end

  def save()
    sql = "INSERT INTO films (title, price)
        VALUES ($1, $2) RETURNING id"
    values = [@title, @price]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def Film.all()
    sql = "SELECT * FROM films"
    results = SqlRunner.run(sql)
    return results.map{ |film| Film.new(film)}
  end

  def Film.delete_all()
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

  def customers()
    sql = "SELECT customers.* FROM customers INNER JOIN
          tickets ON tickets.customer_id = customers.id
          WHERE tickets.film_id = $1"
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results.map{ |customer| Customer.new(customer) }
  end

end
