# G5 Github Heroku Deployer

Rails engine for G5 Github Heroku Deployers


## Current Version

0.0.1


## Requirements

* ["rails", "~> 3.2.0"](http://rubygems.org/gems/rails)
* ["heroku_resque_autoscaler", "~> 0.1.0"](http://rubygems.org/gems/heroku_resque_autoscaler)
* ["github_heroku_deployer", "~> 0.2.0"](http://rubygems.org/gems/github_heroku_deployer)
* ["g5_hentry_consumer", "~> 0.2.6"](https://github.com/g5search/g5_hentry_consumer)


### Gemfile

Add these lines to your application's Gemfile.

```ruby
source "https://gems.gemfury.com/88yeKzEGfizstwBaXVqj/"

gem "g5_github_heroku_deployer"
```

### From Gemfury Command line

Add the Source URL to your .gemrc with this command:

```bash
gem sources -a https://gems.gemfury.com/88yeKzEGfizstwBaXVqj/
gem install g5_github_heroku_deployer
```

Or use it a single install:

```
gem install g5_github_heroku_deployer --source https://gems.gemfury.com/88yeKzEGfizstwBaXVqj/
```


## Usage

Add to `config/application.rb`
```
# load G5GithubHerokuDeployer::Engine with highest priority
# followed by application and other railties
# allows overridding in main app
config.railties_order = [G5GithubHerokuDeployer::Engine, :main_app, :all]
# include G5GithubHerokuDeployer::Engine's migrations
config.paths['db/migrate'] += G5GithubHerokuDeployer::Engine.paths['db/migrate'].existent
```

You get these routes and views for free:
```bash
TODO
```


## Authors

  * Jessica Lynn Suttles / [@jlsuttles](https://github.com/jlsuttles)
  * Bookis Smuin / [@bookis](https://github.com/bookis)


## Contributing

1. Fork it
2. Get it running
3. Create your feature branch (`git checkout -b my-new-feature`)
4. Write your code and **specs**
5. Commit your changes (`git commit -am 'Add some feature'`)
6. Push to the branch (`git push origin my-new-feature`)
7. Create new Pull Request

If you find bugs, have feature requests or questions, please
[file an issue](https://github.com/g5search/g5_github_heroku_deployer/issues).


## Specs

```bash
rspec spec
```


## Releases

```bash
vi lib/g5_github_heroku_deployer/version.rb # change version
vi README.md # change version
git add . && git commit -m "bumps version" && git push
git tag -a -m "Version v0.0.0" v0.0.0 && git push --tags
rake build
fury push pkg/g5_github_heroku_deployer-0.0.0.pkg
```
