# Sidekiq Canary
[![Build Status](https://travis-ci.org/dmathieu/sidekiq-canary.svg?branch=master)](https://travis-ci.org/dmathieu/sidekiq-canary)

Deploy sidekiq sensitive changes in canaries

## Installation

Add the gem to your Gemfile

```ruby
gem 'sidekiq-canary'
```

Extend your workers with it

```ruby
class MyAwesomeWorker
  include Sidekiq::Worker
  extend Sidekiq::Canary

  def perform
    # Do something awesome
  end
end
```

## Usage

Sidekiq Canary will allow you to randomly push workers to a queue or another.
That means if you deploy a new version of your worker in another app, running
the canary queue, only a random subset of them will run the new version.

All other ones will keep running as before. If a failure happens, the same
randomizer will be applied again.

In order to do that, you need two apps. Your main one will run the default queue.
The second one will run a `default_canary` queue.

when deploying a sensitive change, you need to deploy the canary app only, and
set the `default_canary_percent` environment variable on the app which triggers
the job.

Once this is done, all jobs will have the specified percentage number of
chances of being picked to run in the canary instead of the main app.

When your experiment is over, you can bring back the canary percentage to zero
and deploy your changes to your main app.
