module RailsPushAndMigrate
  class Base
    attr_accessor :branch, :remote
    def initialize(remote, branch)
      @branch = branch
      @remote = remote
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

    def print_and_execute(cmd)
      puts "Executing #{cmd}"
      system cmd
    end

    def print_and_execute!(cmd)
      unless print_and_execute(cmd)
        raise "Failed to execute #{cmd}"
      end
    end

    def run
      print_and_execute! git_push_cmd
      print_and_execute!(migrate_cmd) if has_migration?
    end
  end
end
