# Sharpspring + Perfect Audience Notes App

[![Build Status](https://travis-ci.org/joemccann/dillinger.svg?branch=master)](https://travis-ci.org/joemccann/dillinger)

Notes is a cloud-based note taking app built on Ruby on Rails and hosted on Heroku.

  - Users can register, log in and log out
  - Users can add, create, view and delete notes
  - User can view miscellaneous information about how this app was built.

### Tech

Notes uses a number of open source projects to work properly:

* Ruby on Rails - 5.2.4.1
* MongoDB - Our NoSQL-like document database
* Mongoid - Our Ruby driver to connect to MongoDB
* MongoDB Atlas - Our cloud based MongoDB cluster
* JQuery - Lightweight JavaScript framework
* SemanticUI - Our vanilla SCSS based grid and design framework
* BCrypt - Our encryption library of choice for sensitive data
* Rspec - Our testing framework
* Travis - Our automated CI/CD solution to run our tests
* Puma - Our production server

### Tests

Travis will automaatically run tests when code is merged. Upon successful build it will automatically deploy it to Heroku.

To run manually tests use this command:

```sh
bundle exec rspec spec/ --format documentation
```

### Credentials

Sensitive environment variables are stored in the `credentials.yml.enc` file. To view or update them run this commeand:
```sh
EDITOR="atom --wait" bin/rails credentials:edit
```
Replace `atom` with your editor of choice.

### Development

Want to contribute? Great!

Clone the Notes repository. Submit pull requests and we'll add them if they pass.

License
----

MIT

**Free Software, Oh Yeah!**


### Author

Kadeem Pardue (kadeempardue@gmail.com)
