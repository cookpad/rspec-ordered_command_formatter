# RSpec::OrderedCommandFormatter

When running an RSpec suite in parallelized containers on a Continuous Integration platform, the suite's spec files are split in multiple groups, each one being run in one container.

In order to reproduce a given container's test run, one needs to know what examples ran, and what was the random seed.

This formatter aims at making the process easier by producing a copy-pastable rspec command that includes the random seed and the list of examples.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rspec-ordered_command_formatter', group: :test
```

And then execute:

```sh
$ bundle
```

Or install it yourself as:

```sh
$ gem install rspec-ordered_command_formatter
```

## Usage

Simply pass the formatter to the `rspec` command's options. For example:

```sh
$ rspec --format RSpec::OrderedCommandFormatter --out log/rspec_command.txt
```

### Example on CircleCI

In `.circleci/config.yml`:

```yml
      - run:
          name: RSpec
          command: |
            mkdir -p $CIRCLE_TEST_REPORTS/rspec
            bundle exec rspec \
              --format RspecJunitFormatter --out $CIRCLE_TEST_REPORTS/rspec/rspec.xml \
              --format RspecReproducibleOrderCommand --out log/rspec_command.txt \
              --format progress \
              $(circleci tests glob 'spec/**/*_spec.rb' | circleci tests split --split-by=timings | xargs)
      - run:
          name: Command for reproducible test run
          when: on_fail
          command: |
            cat log/rspec_command.txt
            #
            # Use the following command to reproduce this exact RSpec run,
            # with the same examples in the same order
            # (you can triple-click to select the whole line):
      - store_artifacts:
          path: log
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/cookpad/rspec-ordered_command_formatter.
