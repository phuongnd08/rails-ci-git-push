
require "active_support"
require "active_support/core_ext"
require "thor"
require "fileutils"

module RailsPushAndMigrate
  class Base
    attr_accessor :branch, :remote, :on_ci
    def initialize(branch, remote, on_ci)
      @branch = branch
      @remote = remote
      @on_ci = on_ci
    end

    def remote_branch
      "master"
    end

    def diff_files
      @diff_files ||= (
        with_named_repo do |repo_name|
          puts "Execute git diff #{repo_name}/#{remote_branch}..#{branch} --name-only"
          `git diff #{repo_name}/#{remote_branch}..#{branch} --name-only`.split("\n")
        end
      )
    end

    def with_named_repo
      system "git remote add auto-push-repo #{remote}"
      system "git remote update auto-push-repo"
      result = yield "auto-push-repo"
      system "git remote rm auto-push-repo"
      result
    end

    def has_migration?
      diff_files.include?("db/schema.rb")
    end

    def assets_changed?
      diff_files.select {|f| f.include? "app/assets"}.any?
    end


    def git_push_cmd
      "git push #{remote} #{branch}:#{remote_branch}"
    end

    def migrate_cmd
      raise NotImplementedError
    end

    def run
      system git_push_cmd
      migrate_cmd
    end
  end
end
