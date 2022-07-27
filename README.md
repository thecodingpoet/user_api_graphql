### Prerequisites

- Ruby [2.6.5]
- Rails [6]

## Install Dependencies

```ruby
bundle install
```

### Create and setup the database

Run the following commands to create and setup the database.

```ruby
bundle exec rails db:create
bundle exec rails db:setup
```

### Start the Rails server

You can start the rails server using the command given below.

```ruby
bundle exec rails s
```

## Run Test 

```ruby
bundle exec rspec spec
```

## Dev Documentation 
- Navigate to http://localhost:3000/graphiql
- Check the right panel for Documentation Explorer 
- Check the available queries and mutations
- Note that some of the queries and mutations require authentication. You will need to either:
  - Pass the token in the header of the request like so `Authorization: Bearer <token>`
  - Alternatively, if testing locally with GraphiQL. You can create a .env file and copy the content of .env.sample into it and replace AUTH_TOKEN with a valid token.
