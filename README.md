# Homerview
*Your real estate under control!*

Homerview (Home Overview) is ment for all the people who own or rent somekind of living space.
Software enables to see all the related utility bills in one place and pay them.
Project was started mainly due to personal need for such custom-made application.

## Development setup
ruby-2.4.2
rails-5.1.4

1. Clone the repo
2. `bundle install --path vendor/bundle`
3. Replace database_example.yml with database.yml and set username/password for you dev-environment databases
4. `bundle exec rake db:setup`
5. `bundle exec rake db:migrate`

... and you should be ready to go.
