# Laposta

Ruby client to work with Laposta API (https://api.laposta.nl/)

## Installation

```Bash
gem install laposta
```

## Usage

The auth_token can be obtained from Laposta, in Koppelingen -> API sleutels

Create a Laposta client
```ruby
require 'laposta'
client = Laposta::Client.new(auth_token: 'token')
```

Optionally, set a custom user agent to identify your integration
```ruby
client = Laposta::Client.new(auth_token: 'token', user_agent: 'Eye-Phone Integration (engineering@planet-express.com')
```

### Accounts
```ruby
```

### Campaigns
```ruby
```

### Fields
```ruby
```

### Lists
```ruby
```

### Login
```ruby
```

### Subscribers
```ruby
```

### Webhooks
```ruby
```

