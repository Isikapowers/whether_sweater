# whether_sweater   [![CircleCI](https://circleci.com/gh/Isikapowers/whether_sweater/tree/main.svg?style=shield)](https://circleci.com/gh/Isikapowers/whether_sweater/tree/main)

## Table of contents
* [Description](#description)
* [Learning Goals](#learning-goals)
* [Requirements](#requirements)
* [Database Schema](#database-schema)
* [Setup](#setup)
* [Live App](#live-app)
* [Endpoints](#end-points)
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
![128953870-0b631c97-480e-4cbb-a913-3552d784b4a1](https://user-images.githubusercontent.com/72399033/142913102-cce8aab9-33b8-4391-9b0e-6273959a10c2.png)

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
[Link to Heroku deployment(find user by email endpoint)](https://sweater-weather-denver.herokuapp.com/api/v1/users?email=danny@gmail.com)

## Endpoints
**1. Application Landing Page**

![root](https://user-images.githubusercontent.com/72399033/142911208-019ba49c-935a-4814-ab30-0c52e0608248.png)
  1a Retrive weather for a city
  
  Request:
  ```
  GET /api/v1/forecast?location=denver,co
  Content-Type: application/json
  Accept: application/json
  ```
  
  Response:
  ```
  {
    "data": {
       "id": null,
       "type": "forecast",
       "attributes": {
         "current_weather": {
           "datetime": "2020-09-30 13:27:03 -0600",
           "temperature": 79.4,
           etc
         },
         "daily_weather": [
           {
             "date": "2020-10-01",
             "sunrise": "2020-10-01 06:10:43 -0600",
             etc
           },
           {...} etc
         ],
         "hourly_weather": [
           {
             "time": "14:00:00",
             "conditions": "cloudy with a chance of meatballs",
             etc
           },
           {...} etc
         ]
      }
    }
  }
  ```
  
  1b Background image for a city
  
  Request:
  ```
  GET /api/v1/backgrounds?location=denver,co
  Content-Type: application/json
  Accept: application/json
  ```
  
  Response:
  ```
  status: 200
  body:

   {
     "data": {
       "type": "image",
       "id": null,
       "attributes": {
         "image": {
           "location": "denver,co",
           "image_url": "https://pixabay.com/get/54e6d4444f50a814f1dc8460962930761c38d6ed534c704c7c2878dd954dc451_640.jpg",
           "credit": {
             "source": "pixabay.com",
             "author": "quinntheislander",
             "logo": "https://pixabay.com/static/img/logo_square.png"
           }
         }
       }
     }
   }
   ```

**2. User Registration **

![sign_up](https://user-images.githubusercontent.com/72399033/142911731-3bc0d5f0-5c78-4033-92c1-cff56669c631.png)

  Request:
  ```
  POST /api/v1/users
  Content-Type: application/json
  Accept: application/json

  {
    "email": "whatever@example.com",
    "password": "password",
    "password_confirmation": "password"
  }
  ```
  
  Response:
  ```
  status: 201
  body:

  {
    "data": {
      "type": "users",
      "id": "1",
      "attributes": {
        "email": "whatever@example.com",
        "api_key": "jgn983hy48thw9begh98h4539h4"
      }
    }
  }
  ```
  
**3. Login**

![login](https://user-images.githubusercontent.com/72399033/142912790-8a370d09-e754-4eea-b8a4-c0f280cf3690.png)

  Request:
  ```
  POST /api/v1/sessions
  Content-Type: application/json
  Accept: application/json

  {
    "email": "whatever@example.com",
    "password": "password"
  }
  ```
  
  Response:
  ```
  status: 200
  body:

  {
    "data": {
      "type": "users",
      "id": "1",
      "attributes": {
        "email": "whatever@example.com",
        "api_key": "jgn983hy48thw9begh98h4539h4"
      }
    }
  }
  ```
  
**4. Road Trip**

![road_trip](https://user-images.githubusercontent.com/72399033/142912879-9798fd0f-3e8b-4bdb-82d4-13a5dcea3cb8.png)

  Request:
  ```
  POST /api/v1/road_trip
  Content-Type: application/json
  Accept: application/json

  body:

  {
    "origin": "Denver,CO",
    "destination": "Pueblo,CO",
    "api_key": "jgn983hy48thw9begh98h4539h4"
  }
  ```
  
  Response:
  ```
  {
    "data": {
      "id": null,
      "type": "roadtrip",
      "attributes": {
        "start_city": "Denver, CO",
        "end_city": "Estes Park, CO",
        "travel_time": "2 hours, 13 minutes"
          "weather_at_eta": {
          "temperature": 59.4,
          "conditions": "partly cloudy with a chance of meatballs"
         }
       }
    }
  }
  ```

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
