# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

services = ['Elekter', 'Vesi', 'Telefon', 'Internet', 'Ühistu arve']
services.each do |s|
  unless Service.find_by(name: s).present?
    Service.create(name: s)
  end
end

Invoice.create(
  [
    { service: Service.find_by(name: 'Elekter'),
      user: User.find_by(email: 'andres.ehrenpreis@gmail.com'),
      price: 54.06,
      period: Period.create(
        period_start: Date.new(2017,1,1),
        period_end: Date.new(2017,1,31)
      )
    },
    { service: Service.find_by(name: 'Elekter'),
      user: User.find_by(email: 'andres.ehrenpreis@gmail.com'),
      price: 51.13,
      period: Period.create(
        period_start: Date.new(2017,2,1),
        period_end: Date.new(2017,2,28)
      )
    },
    { service: Service.find_by(name: 'Elekter'),
      user: User.find_by(email: 'andres.ehrenpreis@gmail.com'),
      price: 53.39,
      period: Period.create(
        period_start: Date.new(2017,3,1),
        period_end: Date.new(2017,3,31)
      )
    },
    { service: Service.find_by(name: 'Elekter'),
      user: User.find_by(email: 'andres.ehrenpreis@gmail.com'),
      price: 33.73,
      period: Period.create(
        period_start: Date.new(2017,4,1),
        period_end: Date.new(2017,4,30)
      )
    },
    { service: Service.find_by(name: 'Elekter'),
      user: User.find_by(email: 'andres.ehrenpreis@gmail.com'),
      price: 24.52,
      period: Period.create(
        period_start: Date.new(2017,5,1),
        period_end: Date.new(2017,5,31)
      )
    },
    { service: Service.find_by(name: 'Elekter'),
      user: User.find_by(email: 'andres.ehrenpreis@gmail.com'),
      price: 21.71,
      period: Period.create(
        period_start: Date.new(2017,6,1),
        period_end: Date.new(2017,6,30)
      )
    },
    { service: Service.find_by(name: 'Elekter'),
      user: User.find_by(email: 'andres.ehrenpreis@gmail.com'),
      price: 26.46,
      period: Period.create(
        period_start: Date.new(2017,7,1),
        period_end: Date.new(2017,7,31)
      )
    },
    { service: Service.find_by(name: 'Elekter'),
      user: User.find_by(email: 'andres.ehrenpreis@gmail.com'),
      price: 29.87,
      period: Period.create(
        period_start: Date.new(2017,8,1),
        period_end: Date.new(2017,8,31)
      )
    },
    { service: Service.find_by(name: 'Elekter'),
      user: User.find_by(email: 'andres.ehrenpreis@gmail.com'),
      price: 23.09,
      period: Period.create(
        period_start: Date.new(2017,9,1),
        period_end: Date.new(2017,9,30)
      )
    },
    { service: Service.find_by(name: 'Elekter'),
      user: User.find_by(email: 'andres.ehrenpreis@gmail.com'),
      price: 43.99,
      period: Period.create(
        period_start: Date.new(2017,10,1),
        period_end: Date.new(2017,10,31)
      )
    },
    { service: Service.find_by(name: 'Elekter'),
      user: User.find_by(email: 'andres.ehrenpreis@gmail.com'),
      price: 49.09,
      period: Period.create(
        period_start: Date.new(2017,11,1),
        period_end: Date.new(2017,11,30)
      )
    },
    { service: Service.find_by(name: 'Ühistu arve'),
      user: User.find_by(email: 'andres.ehrenpreis@gmail.com'),
      price: 21.81,
      period: Period.create(
        period_start: Date.new(2017,1,1),
        period_end: Date.new(2017,1,31)
      )
    },
  ]
)
