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
    # ELEKTER:
    { service_id: Service.find_by(name: 'Elekter').id,
      user_id: User.find_by(email: 'andres.ehrenpreis@gmail.com').id,
      price: 54.06,
      period: Period.create(
        length: 'month',
        period_start: Date.new(2017,1,1),
        period_end: Date.new(2017,1,31)
      )
    },
    { service_id: Service.find_by(name: 'Elekter').id,
      user_id: User.find_by(email: 'andres.ehrenpreis@gmail.com').id,
      price: 51.13,
      period: Period.create(
        length: 'month',
        period_start: Date.new(2017,2,1),
        period_end: Date.new(2017,2,28)
      )
    },
    { service_id: Service.find_by(name: 'Elekter').id,
      user_id: User.find_by(email: 'andres.ehrenpreis@gmail.com').id,
      price: 53.39,
      period: Period.create(
        length: 'month',
        period_start: Date.new(2017,3,1),
        period_end: Date.new(2017,3,31)
      )
    },
    { service_id: Service.find_by(name: 'Elekter').id,
      user_id: User.find_by(email: 'andres.ehrenpreis@gmail.com').id,
      price: 33.73,
      period: Period.create(
        length: 'month',
        period_start: Date.new(2017,4,1),
        period_end: Date.new(2017,4,30)
      )
    },
    { service_id: Service.find_by(name: 'Elekter').id,
      user_id: User.find_by(email: 'andres.ehrenpreis@gmail.com').id,
      price: 24.52,
      period: Period.create(
        length: 'month',
        period_start: Date.new(2017,5,1),
        period_end: Date.new(2017,5,31)
      )
    },
    { service_id: Service.find_by(name: 'Elekter').id,
      user_id: User.find_by(email: 'andres.ehrenpreis@gmail.com').id,
      price: 21.71,
      period: Period.create(
        length: 'month',
        period_start: Date.new(2017,6,1),
        period_end: Date.new(2017,6,30)
      )
    },
    { service_id: Service.find_by(name: 'Elekter').id,
      user_id: User.find_by(email: 'andres.ehrenpreis@gmail.com').id,
      price: 26.46,
      period: Period.create(
        length: 'month',
        period_start: Date.new(2017,7,1),
        period_end: Date.new(2017,7,31)
      )
    },
    { service_id: Service.find_by(name: 'Elekter').id,
      user_id: User.find_by(email: 'andres.ehrenpreis@gmail.com').id,
      price: 29.87,
      period: Period.create(
        length: 'month',
        period_start: Date.new(2017,8,1),
        period_end: Date.new(2017,8,31)
      )
    },
    { service_id: Service.find_by(name: 'Elekter').id,
      user_id: User.find_by(email: 'andres.ehrenpreis@gmail.com').id,
      price: 23.09,
      period: Period.create(
        length: 'month',
        period_start: Date.new(2017,9,1),
        period_end: Date.new(2017,9,30)
      )
    },
    { service_id: Service.find_by(name: 'Elekter').id,
      user_id: User.find_by(email: 'andres.ehrenpreis@gmail.com').id,
      price: 43.99,
      period: Period.create(
        length: 'month',
        period_start: Date.new(2017,10,1),
        period_end: Date.new(2017,10,31)
      )
    },
    { service_id: Service.find_by(name: 'Elekter').id,
      user_id: User.find_by(email: 'andres.ehrenpreis@gmail.com').id,
      price: 49.09,
      period: Period.create(
        length: 'month',
        period_start: Date.new(2017,11,1),
        period_end: Date.new(2017,11,30)
      )
    },
    # ÜHISTU ARVE
    { service_id: Service.find_by(name: 'Ühistu arve').id,
      user_id: User.find_by(email: 'andres.ehrenpreis@gmail.com').id,
      price: 21.81,
      period: Period.create(
        length: 'month',
        period_start: Date.new(2017,1,1),
        period_end: Date.new(2017,1,31)
      )
    },
  ]
)
