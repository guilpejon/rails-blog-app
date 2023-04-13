Airport.create!(code: 'ATL')
Airport.create!(code: 'DFW')
Airport.create!(code: 'DEN')
Airport.create!(code: 'ORD')
Airport.create!(code: 'LAX')
Airport.create!(code: 'CLT')
Airport.create!(code: 'MCO')
Airport.create!(code: 'LAS')
Airport.create!(code: 'PHX')
Airport.create!(code: 'MIA')
Airport.create!(code: 'JFK')
Airport.create!(code: 'PHL')
Airport.create!(code: 'SAN')
Airport.create!(code: 'TPA')
Airport.create!(code: 'DCA')
Airport.create!(code: 'AUS')

25.times do
  date = rand(Date.civil(2023, 1, 1)..Date.civil(2023, 12, 31))

  Flight.create(
    departure_airport: Airport.all.sample,
    arrival_airport: Airport.all.sample,
    start_datetime: date,
    flight_duration: rand(1..10),
    passenger_count: rand(1..4)
  )
end
