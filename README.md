# hOverView
*Your real estate under control!*

hOverView (Home Overview) is ment for all the people who own or rent somekind of living space.
Software will enable to manage all the utility bills of the living space. Colorful statistics and overview is also included.
Project was started mainly due to personal need for such custom-made application.

## Development setup
ruby-2.5.0
rails-5.1.4

1. Clone the repo
2. `bundle pack`
3. Replace database_example.yml with database.yml and set username/password for you dev-environment databases
4. `bundle exec rake db:setup`
5. `bundle exec rake db:migrate`
