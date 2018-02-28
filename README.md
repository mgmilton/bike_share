# Bike Share

Bike Share is a Ruby on Rails web server that utilizes ActiveRecord to parse through [SF Bay Area Bike Share data](https://www.kaggle.com/benhamner/sf-bay-area-bike-share/data). In this project, a station has many trips and trips have many weather conditions. Upon signing up, a user can view data analytics by clicking the dashboard links in the dropdown. Each station, trip, and condition page has a built in form where a user can create their own.

Additionally, we built an online commerce platform that allows for users to purchase items. A visitor can locate the store by clicking link the bike share header where they will see 12 with defaulted images.

![schema](https://i.imgur.com/2NsFqq6.png)
## Table of Contents
- [Geting Started](#getting-started)
- [Prerequisites](#prequisites)
- [Installing](#installing)
- [Running the Tests](#running-the-tests)
- [End to End Testing](#break-down-into-end-to-end-tests)
- [Coding Style Tests](#and-coding-style-tests)
- [Built With](#built-with)
- [Deployment](#deployment)
- [Contributing](#contributing)
- [Authors](#authors)
- [Acknowledgements](#acknowledgments)

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

## Prerequisites

What things you need to install the software and how to install them

May want to include:

* Ruby version 2.5
* Rails version 5.1.5
* Postgress version 2.0
* Bcrypt verision 3.1.7  
* Puma version 3.7
* SASS-Rails version 5.0

* System dependencies

```
bundle
```

## Installing

A step by step series of examples that tell you have to get a development environment running

Say what the step will be

May want to include:
* To configure the database run the following commands.

```
rails db:create
rails db:migrate
rails db:seed
```
And if that fails, YOLO:

```
rails db:reset
```
To view some complex data querying run the following:

```
rails c
Station.most_frequent_origination
Trip.station_with_most_starts_name
Condition.rides_by_temperature
```


## Running the tests
In order to run the test suite, run the following command:
```
rspec
```
## Break down into end to end tests

* Simple Model Test:

The following test ensures that a user has an email and he or she can be assigned a role of admin.

```
rspec spec/models/user_spec.rb
```

* Complex Model Test:
The following test ensures that a station has all the proper attributes (name, dock count, city, installation, latitude and longitude) and that the name is unique. The instance method ```.most_frequent_zip_code``` selects the most frequent trip zip code associated with this station.

```
rspec spec/models/station_spec.rb
```

* Simple Feature Test:

When a visitor goes to the root page, he or she can login.

```
rspec spec/features/visitor/logins/visitor_can_login_as_a_user_spec.rb
```

* Complex Feature Test:
This test evaluates that an administrator can visit the bike-shop path and click edit, fill in information about the item. After hitting submit the item's attributes have changed.

```
rspec spec/features/admin/items/admin_edits_an_item_spec.rb
```


* Simple Factory Test:

```
rspec spec/features/visitor/logins/visitor_can_login_as_a_user_spec.rb
```

* Complex Factory Test
```
rspec spec/features/user/conditions/user_or_admin_can_see_rides_by_weather_spec.rb
```


## Built With

* [paperclip](https://github.com/thoughtbot/paperclip)
* [bootstrap](https://github.com/twbs/bootstrap)
* [capybara](https://github.com/teamcapybara/capybara)
* [factorybot](https://github.com/thoughtbot/factory_bot)
* [database cleaner](https://github.com/DatabaseCleaner/database_cleaner)

## Deployment
```
heroku create
heroku apps
heroku open
rake assets:clobber
git add .
git commit -m "clobbers existing assets"

heroku rake db:reset
heroku rake db:migrate
heroku rake db:seed
```


## Contributing

Please feel free to submit pull requests and suggestions to this repository. We would love your feedback.

## Authors

* [Cameron Johnson](https://github.com/slimecog)
* [Matt Milton](https://github.com/mgmilton)
* [Anna Royer](https://github.com/annaroyer)

## Acknowledgments

* To our wonderful instructors at [Turing](https://github.com/turingschool), thanks for all the laughs, thorough debugging sessions, and movie mania.
