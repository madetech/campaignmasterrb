#campaignmasterb

[![Build Status](https://secure.travis-ci.org/madebymade/campaignmasterrb.png)](http://travis-ci.org/madebymade/campaignmasterrb)

Ruby interface that allows you to send subscribers to a [Campaign Master](http://www.campaignmaster.co.uk/) list.

Currently no other Campaign Master API functions are supported, though it should be trivial to add these.


##Installation

Campaignmasterrb is available via Rubygems:

```
gem install campaign_master
```

or add it to your Gemfile:

```
gem 'campaign_master'
```

You'll also currently need to add the GitHub build of the [Savon client](http://savonrb.com/). When the version of Savon on RubyGems has been updated we'll add this as a proper dependency.

```ruby
gem 'savon', :git => 'https://github.com/savonrb/savon.git', :ref => '5acd246'
```


##Basic usage

```ruby
require 'campaign_master'

format = "EmailAddress,First_Name,IsActive\r\n"
subscribers = "test@example.org,Derek,1\r\ntest2@example.org,Doreen,1"
delimiter = ","

client = CampaignMaster.client(username, password, client_id)
client.call(:Subscriber).import(format, delimiter, suscribers)
```

The format string can contain any fields supported by Campaign Master.


##License

Licensed under [New BSD License](http://opensource.org/licenses/BSD-3-Clause)
