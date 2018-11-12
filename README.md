# WalkingDead

find dead links.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'walking_dead', git: 'https://github.com/yasslab/walking_dead.git'
```

And then execute:

    $ bundle

<!--
Or install it yourself as:

    $ gem install walking_dead
-->

## Usage

```ruby
require 'rake'
require 'walking_dead'
require 'yaml'
yaml = <<~YAML
paths:
- app/views/**/*
- public/**/*.{html,html.erb}
YAML
options = YAML.load(yaml)
config = WalkingDead::Config.new(options)
walking_dead = WalkingDead.new(config)
walking_dead.each do |url, res|
  if res.code == '301'
    sh 'git', 'gsub', url, res['location']
  end
  File.open("#{res.code}.txt", "a") do |f|
    f.puts url
  end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/yasslab/walking_dead. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the WalkingDead project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/yasslab/walking_dead/blob/master/CODE_OF_CONDUCT.md).
