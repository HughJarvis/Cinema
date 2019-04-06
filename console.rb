require( 'pry-byebug' )
require_relative( 'models/film.rb' )
require_relative( 'models/customer.rb' )
require_relative( 'models/ticket.rb' )

film1 = Film.new ({
  'title' => 'Airplane!',
  'price' => '10'
  })

film1.save()

film2 = Film.new ({
  'title' => 'E.T.',
  'price' => '10'
  })

film2.save()

film3 = Film.new ({
  'title' => 'The Lego Movie',
  'price' => '10'
  })

film3.save()

customer1 = Customer.new ({
  'name' => 'Hugh',
  'funds' => '30'
  })

customer1.save

customer2 = Customer.new ({
  'name' => 'Jo',
  'funds' => '40'
  })

customer2.save()

customer3 = Customer.new ({
  'name' => 'Milo',
  'funds' => '20'
  })

customer3.save()

customer4 = Customer.new ({
  'name' => 'Ruth',
  'funds' => '20'
  })

customer4.save()

ticket1 = Ticket.new ({
  'customer_id' => customer1.id,
  'film_id' => film2.id
  })

ticket1.save()

ticket2 = Ticket.new ({
  'customer_id' => customer2.id,
  'film_id' => film1.id
  })

ticket2.save()

ticket3 = Ticket.new ({
  'customer_id' => customer3.id,
  'film_id' => film3.id
  })

ticket3.save()

ticket4 = Ticket.new ({
  'customer_id' => customer4.id,
  'film_id' => film3.id
  })

ticket4.save()

binding.pry
nil
