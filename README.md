# G5 Sibling Deployer

Rails engine for G5 Sibling Deployers


## Current Version

0.0.1


## Requirements

* ["rails", "~> 3.2.7"](http://rubygems.org/gems/rails)
* ["table_cloth", "~> 0.2.1"](http://rubygems.org/gems/table_cloth)
* ["state_machine", "~> 1.1.2"](http://rubygems.org/gems/state_machine)
* ["heroku_resque_autoscaler", "~> 0.1.0"](http://rubygems.org/gems/heroku_resque_autoscaler)
* ["github_heroku_deployer", "~> 0.2.0"](http://rubygems.org/gems/github_heroku_deployer)
* ["g5_hentry_consumer", "~> 0.2.7"](https://github.com/g5search/g5_hentry_consumer)


## Installation

### Gemfile

Add these lines to your application's Gemfile.

```ruby
source "https://gems.gemfury.com/88yeKzEGfizstwBaXVqj/"

gem "g5_sibling_deployer"
```

### From Gemfury Command line

Add the Source URL to your .gemrc with this command:

```bash
gem sources -a https://gems.gemfury.com/88yeKzEGfizstwBaXVqj/
gem install g5_sibling_deployer
```

Or use it a single install:

```
gem install g5_sibling_deployer --source https://gems.gemfury.com/88yeKzEGfizstwBaXVqj/
```


## Usage

Export environment variables:
```bash
export MAIN_APP_UID=http://g5-configurator.herokuapp.com/apps/1
```

Add to `config/application.rb`:
```ruby
# load G5SiblingDeployer::Engine with highest priority
# followed by application and other railties
# allows overridding in main app
config.railties_order = [G5SiblingDeployer::Engine, :main_app, :all]

# include G5SiblingDeployer::Engine's migrations
config.paths['db/migrate'] += G5SiblingDeployer::Engine.paths['db/migrate'].existent
```

Run migrations:
```bash
rake db:migrate
```

Seed database:
```bash
rake sibling:consume
rake sibling:instruction:consume
```

You get these routes and views for free:
```bash
         deploy_sibling POST /siblings/:id/deploy(.:format)      siblings#deploy
               siblings GET  /siblings(.:format)                 siblings#index
  siblings_instructions GET  /siblings/instructions(.:format)    siblings/instructions#index
       siblings_deploys GET  /siblings/deploys(.:format)         siblings/deploys#index
g5_configurator_webhook POST /webhooks/g5-configurator(.:format) webhooks#g5_configurator
```

You get these rake tasks:
```bash
rake sibling:consume # seeds siblings
rake sibling:deploy # deploys all siblings
rake sibling:instruction:consume # consumes instruction feed
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
[file an issue](https://github.com/g5search/g5_sibling_deployer/issues).


## Specs

```bash
rspec spec
```


## Releases

```bash
vi lib/g5_sibling_deployer/version.rb # change version
vi README.md # change version
git add . && git commit -m "bumps version" && git push
git tag -a -m "Version v0.0.0" v0.0.0 && git push --tags
rake build
fury push pkg/g5_sibling_deployer-0.0.0.pkg
```
