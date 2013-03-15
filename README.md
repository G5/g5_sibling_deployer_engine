# G5 Sibling Deployer

Provides models, views, controllers, routes, and rake tasks for deploying Sibling Apps.


## Current Version

0.2.0


## Requirements

* ["rails", "~> 3.2.12"](http://rubygems.org/gems/rails)
* ["table_cloth", "~> 0.2.1"](http://rubygems.org/gems/table_cloth)
* ["state_machine", "~> 1.1.2"](http://rubygems.org/gems/state_machine)
* ["heroku_resque_autoscaler", "~> 0.1.0"](http://rubygems.org/gems/heroku_resque_autoscaler)
* ["github_heroku_deployer", "~> 0.2.0"](http://rubygems.org/gems/github_heroku_deployer)
* ["microformats2", "2.0.0.pre1"](http://rubygems.org/gems/microformats2)


## Installation

### Gemfile

Add these lines to your application's Gemfile.

```ruby
source "https://gems.gemfury.com/***REMOVED***/"

gem "g5_sibling_deployer_engine"
```

### From Gemfury Command line

Add the Source URL to your .gemrc with this command:

```bash
gem sources -a https://gems.gemfury.com/***REMOVED***/
gem install g5_sibling_deployer_engine
```

Or use it a single install:

```
gem install g5_sibling_deployer_engine --source https://gems.gemfury.com/***REMOVED***/
```


## Usage

Export environment variables:
```bash
export MAIN_APP_UID=http://g5-configurator.herokuapp.com/apps/1
```

Run migrations:
```bash
rake railties:install:migrations
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
* Michael Mitchell / [@variousred](https://github.com/variousred)


## Contributing

2. Get it running
3. Create your feature branch (`git checkout -b my-new-feature`)
4. Write your code and **specs**
5. Commit your changes (`git commit -am 'Add some feature'`)
6. Push to the branch (`git push origin my-new-feature`)
7. Create new Pull Request

If you find bugs, have feature requests or questions, please
[file an issue](https://github.com/g5search/g5_sibling_deployer_engine/issues).


## Specs

Run once.
```bash
$ rspec spec
```

Keep then running.
```bash
$ guard
```

Coverage.
```bash
$ rspec spec
$ open coverage/index.html
```


## Releases

```bash
vi lib/g5_sibling_deployer_engine/version.rb # change version
vi README.md # change version
git add . && git commit -m "bumps version" && git push
git tag -a -m "Version v0.0.0" v0.0.0 && git push --tags
rake build
fury push pkg/g5_sibling_deployer_engine-0.0.0.pkg
```
