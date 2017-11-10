require_relative 'base'

module RailsPushAndMigrate
  class Heroku < Base
    attr_accessor :app
    def initialize(branch, app)
      @branch = branch
      @app = app
    end

    def remote
      "https://git.heroku.com/#{app}.git"
    end

    def migrate_cmd
      "heroku run rake db:migrate -a #{app}"
    end
  end
end

