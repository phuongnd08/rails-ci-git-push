require_relative 'base'

module RailsPushAndMigrate
  class Heroku < Base
    attr_accessor :app
    def initialize(branch, app, on_ci)
      @branch = branch
      @app = app
      @on_ci = on_ci
    end

    def remote
      "https://git.heroku.com/#{app}.git"
    end

    def migrate_cmd
      "heroku run rake db:migrate -a #{app}"
    end
  end
end

