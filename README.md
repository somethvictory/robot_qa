# README

Robot Factory Coding Challenge

### Requirements

  `rails 5.1.5`

  `ruby >= 2.3`

  `qt 5.5` for feature specs

  `postgresql >= 9.3`

### Features

#### API

```
  GET /robots.json # return all non-shipped robots for QA
```

```
  POST /robots/:id/exitinguish.json # remove 'on fire' status from a robot
```

```
  POST /robots/recycle.json? # remove all the robots associated with the provided ids

  # params: {recycleRobots: [id1, id2, id3, ...]}
```

```
  PUT /shipments/create # create a new shipment and associated all the robots associated with the provided ids

  # params: {robot_ids: [id1, id2, id3, ...]}
```

#### Web app

  Visit application `root_path` to see full list of *Quality Passed* and *Factory Second* robots

  From the same page, the robots can be added to the *Shipping List* which can be submitted with the *Send Shipment* button.

### Set up

```
  bundle install
```

The project uses yarn for javascript package management

```
  brew install yarn
```

#### Database setup
The project uses postgresql 9.3. If you got user and password for your local postgres, you may need to specify the config in the `config/database.yml`

```
  rails db:create
  rails db:migrate
  rails db:seed # to load sample data
```

#### React Rails setup

```
  rails webpacker:install

  rails webpacker:install:react

  rails generate react:install

  yarn install
```

### Start up application
```
  rails server
```

### Test

```
  rspec
```
