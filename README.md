# Laposta

Ruby client to work with Laposta API (https://api.laposta.nl/)

Each API call returns a hash from the raw JSON response from the API. Please see the [API docs](https://api.laposta.nl/) for the exact contents of the response.

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
#### Example account object
```json
{
  "account": {
    "account_id": "1EZsjcmOVT",
    "created": "2012-11-08 21:40:31",
    "modified": null,
    "hostname": "devries",
    "api_key": "Vh9ssijEOkP_CCM2uvQg",
    "company": {
      "name1": "De Vries BV",
      "name2": "Department Apeldoorn"
    },
    "users": [
      {
        "user": {
          "user_id": "hag8FEWrQp",
          "created": "2012-11-08 21:40:31",
          "modified": null,
          "login": "robin@example.net",
          "password": null,
          "email": "robin@example.net",
          "sex": "male",
          "name1": "Robin",
          "name2": "De Vries",
          "loginlink": "https://login.laposta.nl/url/u/1EZsjcmOVT/hag8FEWrQp"
        }
      }
    ]
  }
}
```

#### API calls
```ruby
# Get all accounts
accounts = client.accounts

# Get a specific account
account = client.get_account("1EZsjcmOVT")

# Create an account
account = client.create_account!(hostname: "devries",
                                 company: { name1: "De Vries BV", name2: "Department Apeldoorn" },
                                 user: { email: "robin@example.net", sex: "male", name1: "Robin", name2: "De Vries" } )
```

### Campaigns
#### Example account object
```json
{
  "campaign": {
    "account_id": "wFiUS4HL4e",
    "campaign_id": "njhgaf61ye",
    "created": "2014-12-11 11:26:19",
    "modified": "2014-12-11 11:27:31",
    "type": "regular",
    "delivery_requested": null,
    "delivery_started": "2014-12-11 11:27:29",
    "delivery_ended": "2014-12-11 11:27:31",
    "name": "My first campaign",
    "subject": "My first campaign",
    "from": {
      "name": "Laposta API",
      "email": "api@laposta.nl"
    },
    "reply_to": "api@laposta.nl",
    "list_ids": {
      "kxhysrt26s": [
        "2noVadDLbd"
      ],
      "t1jmacge9a": [
        "GJn80BiYxo"
      ],
      "shb5vujyxj": [],
      "eiwhvx595g": [
        "PtIXMx2sG0"
      ]
    },
    "stats": {
      "ga": "true",
      "mtrack": "false"
    },
    "web": "https://laposta-api.email-provider.nl/web/wFiUS4HL4e/njhgaf61ye",
    "screenshot": {
      "113x134": "https://app.laposta.nl/clients/images/screenshots/9dknAdbAXm.2.png",
      "226x268": "https://app.laposta.nl/clients/images/screenshots/9dknAdbAXm.2.png"
    }
  }
}
```

#### API calls

```ruby
# Get al campaigns
campaigns = client.campaigns

# Get a specific campaign
campaign = client.get_campaign("njhgaf61ye")

# Add a campaign
campaign = client.create_campaign!(type: "regular",
                                   name: "Test via API",
                                   subject: "Hello from us",
                                   from: { :name, :email },
                                   reply_to: "reply@example.net",
                                   list_ids: ["nnhnkrytua", "srbhotdwob"],
                                   stats: { ga: false, mtrack: true } })
# Update an existing campaign
campaign = client.update_campaign!("njhgaf61ye", name: "Test via API",
                                                 subject: "Hello from us, modified",
                                                 from: { name: "Max de Vries", email: "max@example.net" },
                                                 reply_to: "reply@example.net",
                                                 list_ids: ["nnhnkrytua", "srbhotdwob"],
                                                 stats: { ga: false, mtrack: true } })

# Delete a campaign
campaign = client.delete_campaign!("njhgaf61ye")

# Get the contents of a campaign
campaign = client.get_campaign_content("njhgaf61ye")

# Set the contents of a campaign
campaign = client.fill_campaign_content!("njhgaf61ye", import_url: "https://example.net/newsletter")

# Directly send a campaign
campaign = client.send_campaign!("njhgaf61ye")

# Schedule a campaign for delivery
campaign = client.schedule_campaign!("njhgaf61ye", delivery_requested: "2016-05-19 12:00:00")

# Send a test email
campaign = client.test_campaign!("njhgaf61ye", email: "test@example.com")
```

### Fields
#### Example field object
```json
{
  "field": {
    "field_id": "Z87ysHha9A",
    "list_id": "BaImMu3JZA",
    "created": "2012-02-18 11:42:38",
    "modified": "2012-06-02 14:07:20",
    "state": "active",
    "name": "Name",
    "tag": "{{name}}",
    "custom_name": "name",
    "defaultvalue": "",
    "datatype": "text",
    "datatype_display": null,
    "required": true,
    "in_form": true,
    "in_list": true
  }
}
```

#### API calls
```ruby
# Get a specific field
field = client.get_field("GeVKetES6z", list_id: "srbhotdwob")

# Get all fields for a list
fields = client.get_fields_for_list(list_id: "srbhotdwob")

# Add a field
field = client.create_field!(list_id: "srbhotdwob",
                             name: "Color",
                             defaultvalue: "Green",
                             datatype: "select_single",
                             datatype_display: "radio",
                             options: ["Red", "Green", "Blue"],
                             required: true,
                             in_form: true,
                             in_list: true)

# Update an existing field
field = client.update_field!("GeVKetES6z", list_id: "srbhotdwob",
                                           name: "Color",
                                           defaultvalue: "Green",
                                           datatype: "select_single",
                                           datatype_display: "radio",
                                           options: ["Red", "Green", "Blue"],
                                           required: true,
                                           in_form: true,
                                           in_list: true)

# Delete a field
field = client.delete_field!("GeVKetES6z", list_id: "srbhotdwob")
```

### Lists
#### Example list object
```json
{
  "list": {
    "list_id": "BaImMu3JZA",
    "created": "2012-02-18 11:42:38",
    "modified": "2012-06-02 14:07:20",
    "state": "active",
    "name": "Testlist",
    "remarks": "A list for testing purposes",
    "subscribe_notification_email": "subscription@example.net",
    "unsubscribe_notification_email": "unsubscription@example.net",
    "members": {
      "active": 1232,
      "unsubscribed": 113,
      "cleaned": 14
    }
  }
}
```

#### API calls
```ruby
# Get al lists
lists = client.lists

# Get a specific list
list = client.get_list("BaImMu3JZA")

# Add a list
list = client.create_list!(name: "Testlist",
                           remark: "A list for testing purposes.",
                           subscribe_notification_email: "subscription@example.net",
                           unsubscribe_notification_email: "unsubscription@example.net")
# Update an existing list
list = client.update_list!("BaImMu3JZA", name: "Testlist",
                                         remark: "A list for testing purposes.",
                                         subscribe_notification_email: "subscription@example.net",
                                         unsubscribe_notification_email: "unsubscription@example.net")

# Delete a list
list = client.delete_list!("BaImMu3JZA")

# Remove all members from a list
list = client.purge_list!("BaImMu3JZA")

```

### Login
#### API calls
```ruby
login = client.login(login: "maartje@example.nl" password: "1h2moooRTTR2")
```

### Subscribers
#### Example member object
```json
{
  "member": {
    "member_id": "9978ydioiZ",
    "list_id": "BaImMu3JZA",
    "email": "maartje@example.net",
    "state": "active",
    "signup_date": "2012-08-13 16:13:07",
    "modified": "2012-08-13 16:14:27",
    "ip": "198.51.100.10",
    "source_url": "http://example.com",
    "custom_fields": {
      "name": "Maartje de Vries",
      "dateofbirth": "1973-05-10 00:00:00",
      "children": 2,
      "prefs": [
        "optionA",
        "optionB"
      ]
    }
  }
}
```

#### API calls
```ruby
# Get a specific subscriber
subscriber = client.get_subscriber("9978ydioiZ", list_id: "BaImMu3JZA", state: "active")

# Get all subscribers for a list
subscribers = client.get_subscribers_for_list(list_id: "BaImMu3JZA", state: "active")

# Add a subscriber
subscriber = client.create_subscriber!(list_id: "BaImMu3JZA",
                                       ip: "198.51.100.10",
                                       email: "maartje@example.net",
                                       source_url: "http://example.com",
                                       custom_fields: { dateofbirth: "1973-05-10", children: 2, prefs: ["optionA", "optionB"] },
                                       options: { suppress_email_notification: true })

# Update an existing subscriber
subscriber = client.update_subscriber!("9978ydioiZ", list_id: "BaImMu3JZA",
                                                     email: "maartje@example.net",
                                                     state: "unsubscribed",
                                                     custom_fields: { name: "Maartje de Vries - Abbink", children: 3 })

# Delete a subscriber
subscriber = client.delete_subscriber!("9978ydioiZ")
```

### Webhooks
#### Example webhook object
```json
{
  "webhook": {
    "webhook_id": "cW5ls8IVJl",
    "list_id": "BaImMu3JZA",
    "created": "2012-10-31 17:03:21",
    "modified": "2012-10-31 17:12:08",
    "state": "active",
    "event": "subscribed",
    "url": "http://example.net/webhook.asp",
    "blocked": false
  }
}
```

#### API calls
```ruby
# Get a specific webhook
webhook = client.get_webhook("cW5ls8IVJl", list_id: "BaImMu3JZA")

# Get all webhooks for a list
webhooks = client.get_webhooks_for_list(list_id: "BaImMu3JZA")

# Add a webhook
webhook = client.create_webhook!(list_id: "BaImMu3JZA",
                                 event: "modified",
                                 url: "http://example.com/webhook.pl",
                                 blocked: false)

# Update an existing webhook
webhook = client.update_webhook!("cW5ls8IVJl", list_id: "BaImMu3JZA",
                                               event: "modified",
                                               url: "http://example.com/webhook.pl",
                                               blocked: false)

# Delete a webhook
webhook = client.delete_webhook!("cW5ls8IVJl", list_id: "BaImMu3JZA")
```

