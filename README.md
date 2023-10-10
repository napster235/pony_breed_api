# PonyBreeds API :horse:

The **PonyBreed API** provides an interface for the [**PonyBreeds**](https://github.com/napster235/pony_breeds) ruby gem.
At the moment, the API is hosted on **Render** using a free tier, so the first request might be a bit slow.

## Getting started

In order to use this API locally, you will need to have Ruby and Rails installed on your system.

Once you have these prerequisites installed, follow these steps:

1. Clone this repository to your local machine
2. Navigate to the project directory and run `bundle install`
3. Start the API server by running `rails server`

## Usage

Retrieve the pony data by the JSON key<br>
GET `https://pony-breed-api.onrender.com/api/v1/pony_by_key?key=american_walking_pony`

```ruby
{
  name: 'American Shetland Pony',
  description: 'Short description about the pony',
  wiki_url: 'https://en.wikipedia.org/wiki/American_Shetland_Pony'
}
```

Retrieve the pony data by the actual name of the pony<br>
GET `https://pony-breed-api.onrender.com/api/v1/pony_by_name?name=American Walking Pony`

```ruby
{
  name: 'American Walking Pony',
  description: 'Short description about the pony',
  wiki_url: 'https://en.wikipedia.org/wiki/American_Walking_Pony"'
}
```

Retrieve data for a random pony<br>
 GET `https://pony-breed-api.onrender.com/api/v1/random_pony`

```ruby
{
  name: 'Timor pony',
  description: 'Short description about the pony',
  wiki_url: 'https://en.wikipedia.org/wiki/Timor_Pony'
}
```

Note: All responses are in the **JSON** format

## Contributing

Contributions are welcomed to this project!
If you have an idea for a new feature or find a bug, please open an issue in this repository.

To contribute code to the project, follow these steps:

    1. Fork this repo 
    2. Create a new branch for your changes
    3. Make the necessary changes and commit them to your branch
    4. Push your branch to your forked repository
    5. Open a pull request from your branch to this repository

I will review your changes and merge them into the project if they are approved.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
