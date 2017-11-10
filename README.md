server-keeper
==========

Used to provision  apps on heroku. May be other types of env as well.

Idea: Provide a number of mixins. Mix it to a thor task and you are
good to go.

Example of thor task (puts it in bin/your-task)

```
#!/usr/bin/env ruby

require 'keeper'
require "thor"

class YourAction < Keeper::HerokuAction
  def initialize(app_name)
    @app_name = app_name
  end

  def perform
  end
end

class YourCLI < Thor
  desc "create app-name", "Create an app based on profiles/app-name/ settings"
  def create(app_name)
    YourAction.new(app_name).perform
  end
end

YourCLI.start
```

```
$ bundle exec bin/your-task create app-name
```
