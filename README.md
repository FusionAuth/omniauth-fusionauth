# OmniAuth FusionAuth

## How to use this SDK

#### Installation

Add to your Gemfile:

```ruby
gem 'omniauth-fusionauth'
```

### Usage

If you are already using OmniAuth, adding FusionAuth is as simple as adding a new provider to your `OmniAuth::Builder`.

For example, in Rails you would add this in `config/initializers/omniauth.rb`:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :fusionauth, ENV['FUSIONAUTH_CLIENT_ID'], ENV['FUSIONAUTH_CLIENT_SECRET'], {scope: 'openid' }
  # other providers here
end
