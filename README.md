# DevHunter

This web application is my take on how to build a platform to connect employer and applicants.

## Getting Started

Clone the project and follow the [Installing](#Installing) steps 

### Prerequisites

You must have Ruby and Rails, you could use [RVM](https://github.com/rvm/rvm), or any other versioning tool of your choice.

```
\curl -sSL https://get.rvm.io | bash -s stable --rails
```

### Installing

First change directory to the root folder of the app, and then install Ruby

If you are using RVM it would be something like this

```
rvm install ruby-2.6.3
```

Then setup the app by running

```
bin/setup
```

To start the server run

```
rails server
```

You should be good to go, browse through the app by accessing http://localhost:3000

## Running the tests

This project uses Rspec for the automated tests, you can test by running

```
rspec
```

If you have all dependencies installed this should show the time and number of tests.

You can find the tests files in the `/spec` folder, they are divided in subfolders accordingly with each name.

## Tools used in this project:

- Ruby - 2.6.3

- Rails - 6.0

- Database - SQLite3

- Test Suite - [Capybara](https://github.com/teamcapybara/capybara) with [RSpec](https://github.com/rspec/rspec-rails), and [FactoryBot](https://github.com/thoughtbot/factory_bot_rails)

- Authentication - [Devise](https://github.com/plataformatec/devise)

- Front-end solution - [Bootstrap](https://getbootstrap.com/)

- Formatting - [RuboCop](https://github.com/rubocop-hq/rubocop)
