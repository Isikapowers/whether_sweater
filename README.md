# whether_sweater   [![CircleCI](https://circleci.com/gh/Isikapowers/whether_sweater/tree/main.svg?style=shield)](https://circleci.com/gh/Isikapowers/whether_sweater/tree/main)

## Table of contents
* [Description](#description)
* [Learning Goals](#learning-goals)
* [Requirements](#requirements)
* [Database Schema](#database-schema)
* [Setup](#setup)
* [Live App](#live-app)
* [Tools Used](#tools-used)
* [Contributors](#contributors)

## Description

"Whether, sweater?" is the back-end of a hypothetical application to plan road trips. This app will allow users to see the current weather as well as the forecasted weather at the destination.

## Learning Goals
- Expose an API that aggregates data from multiple external APIs.
- Expose an API that requires an authentication token.
- Determine completion criteria based on the needs of front-end developers.
- Research, select, and consume an API based on your needs as a developer.

## Requirements
- Rails 5.2.5
- Ruby 2.7.2
- PostgreSQL
- Circle CI
- Test all feature and model code
- Deploy completed code to Heroku

## Database Schema


## Setup
* Fork this repository
* Clone your fork
* From the command line, install gems and set up your DB:
    * `bundle install`
    * `rails db:{create,migrate}`
* Create an account with Open Weather Map and request an API key.
* Create an account with Mapquest and request an API key.
* Create an account with Unsplash and request an API key.
* install teh Figaro gem and run
    * `bundle exec figaro install`
    * Add your API keys to `config/application.yml`
* Run the test suite with `bundle exec rspec`.
* Run RuboCop linter with `bundle exec rubocop`.
* Run your development server with `rails s` to see the app in action.

```
  OPEN_WEATHER_KEY: your_api_key
  MAPQUEST_KEY: your_mapquest_key
  UNSPLASH_KEY: your_unsplash_key
``` 

## Live App
[Link to Heroku deployment](https:/sweater-weather-denver.herokuapp.com/api/v1/forecast)

## Tools Used

| Development    |  Testing             |
| :-------------:| :-------------------:|
| Ruby 2.7.2     | SimpleCov            |
| Rails 5.2.6    | Pry                  |
| HTML5          | Capybara             |
| Bootstrap      | ShouldaMatcher       |
| Atom           | Launchy              |
| Git            | Orderly              |
| Github         | Factorybot/Faker     |
| Github Project | Faraday              |
| Postico        | RSpec                |
| Heroku         | Travis CI            |
| Bcrypt         | RuboCop              |

## Contributor

- [Isika Powers](https://github.com/Isikapowers/)
