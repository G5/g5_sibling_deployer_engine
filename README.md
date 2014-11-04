# G5 Sibling Deployer Engine

[![Build Status](https://travis-ci.org/G5/g5_sibling_deployer_engine.png?branch=master)](https://travis-ci.org/G5/g5_sibling_deployer_engine)
[![Code Climate](https://codeclimate.com/repos/531273cf6956803c53001d6f/badges/1f71ed4b6e818344987e/gpa.png)](https://codeclimate.com/repos/531273cf6956803c53001d6f/feed)

Provides models, views, controllers, routes, and rake tasks for deploying Sibling Apps.


## Current Version

0.6.2


## Requirements

* ["rails"](http://rubygems.org/gems/rails)
* ["state_machine"](http://rubygems.org/gems/state_machine)
* ["heroku_resque_autoscaler"](http://rubygems.org/gems/heroku_resque_autoscaler)
* ["github_heroku_deployer"](http://rubygems.org/gems/github_heroku_deployer)
* ["microformats2"](http://rubygems.org/gems/microformats2)


## Installation

Add these lines to your application's Gemfile.

```ruby
gem "g5_sibling_deployer_engine"
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
[file an issue](https://github.com/G5/g5_sibling_deployer_engine/issues).


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


## License

Copyright (c) 2013 G5

MIT License

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
