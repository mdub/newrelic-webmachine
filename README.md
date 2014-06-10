# NewRelic::Webmachine

NewRelic instrumentation for [Webmachine][webmachine].

## Installation

Add this line to your application's Gemfile:

    gem 'newrelic-webmachine'

And then execute:

    $ bundle

## Usage

In your application's boot process, e.g. in `config.ru`

    require 'newrelic-webmachine'

Assuming you've configured NewRelic correctly, you should now see requests handled by Webmachine traced in NewRelic.

## Contributing

Made it better?  Please submit a [pull request][github-pr].

1. Fork it.
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

[webmachine]: https://github.com/seancribbs/webmachine-ruby
[github-pr]: https://github.com/mdub/newrelic-webmachine
