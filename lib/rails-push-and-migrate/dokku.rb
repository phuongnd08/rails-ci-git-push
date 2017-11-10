require_relative 'base'

module RailsPushAndMigrate
  class Dokku < Base
    def dokku_path
      File.expand_path("../../../bin/dokku_client.sh", __FILE__)
    end

    def migrate_cmd
      cmds = [
        "git remote add dokku #{remote}",
        "#{dokku_path} run rake db:migrate"
      ].join(" && ")
    end
  end
end
