# ET to ATOS File Transfer

[![Build Status](https://dev.azure.com/HMCTS-PET/pet-azure-infrastructure/_apis/build/status/et-atos-api-file-transfer?branchName=develop)](https://dev.azure.com/HMCTS-PET/pet-azure-infrastructure/_build/latest?definitionId=15&branchName=develop)

This gem is intended to be used in the Employment Tribunal JADU Replacement project. It keeps the ATOS interface separate with the
goal of being able to use it as a standalone rack app OR just mount it inside a rails app..

## Installation - For use as a mountable engine inside another rails application

Add this line to your application's Gemfile:

```ruby
gem 'et_atos_file_transfer'
```

And then execute:

$ bundle

Or install it yourself as:

$ gem install et_atos_file_transfer

## Running Standalone

First, clone this repository into et_atos_file_transfer

Then

```

cd et_atos_file_transfer/rails_container

./bin/setup

```

Then, setup the following environment variables

Required

SECRET_KEY_BASE - Just make up a random 128 character hex string

DB_HOST - Must be the same as for the API service (defaults to localhost)
DB_USERNAME - Must be the same as for the API service (defaults to postgres)
DB_PASSWORD - Must be the same as for the API service (defaults to postgres)
DB_PORT - Must be the same as for the API service (defaults to 5432)

AZURE_STORAGE_ACCOUNT - Must be the same as for the API service (defaults to the azurite standard development account)
AZURE_STORAGE_ACCESS_KEY - Must be the same as for the API service (defaults to the azurite standard development key)
AZURE_STORAGE_CONTAINER - Must be the same as for the API service (defaults to et_api_container the same as the API)

Optional


AZURE_STORAGE_BLOB_FORCE_PATH_STYLE - Used in development / test environments to specify that that container name is part of the path instead of a subdomain
AZURE_STORAGE_BLOB_HOST - Used in development / test environments to point to the azurite server

```

./bin/rails s



```
## Dependencies

Currently, the application relies on the following from the app where it is mounted

1. Active Record
2. Active Storage
3. ExportedFile model

## Usage

### To Mount Into Rails App

In your config/routes.rb

```ruby

  mount EtAtosFileTransfer, at: '/atos_api'


```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
