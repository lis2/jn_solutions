require 'rubygems'
require 'zip/zip'
require 'zip/zipfilesystem'

class GitHub
  class << self
    def limit_exceeded?
      response = HTTParty.get("https://api.github.com/repos/#{JnSolutions::Application.config.git_hub}/commits")
      response.code == 200 ? false : true
    end

    def load_commits
      response = HTTParty.get("https://api.github.com/repos/#{JnSolutions::Application.config.git_hub}/commits")
      response.each do |commit|
        Commit.create(commit_created_at: commit['commit']['committer']['date'],
          author: commit['author']['login'],
          sha: commit['sha'],
          message: commit['commit']['message'])
      end
    end

    def make_zip(commit)
      rm("archive/" + commit + ".zip")
      create_directory_unless_exists?("clone")
      clone_repo
      checkout(commit)
      zip(commit)
      move_to_archive(commit)
      rm("clone")
    end

    private
    def rm(name)
      `rm -rf #{name}`
    end
    def create_directory_unless_exists?(name)
      Dir.mkdir(name) unless File.exists?(name)
    end

    def clone_repo
      `git clone https://github.com/#{JnSolutions::Application.config.git_hub}.git clone`
    end

    def checkout(commit)
      `cd clone && git reset --hard #{commit}`
    end

    def zip(commit)
      archive = File.basename(commit) + ".zip"
      FileUtils.rm archive, :force=>true

      Zip::ZipFile.open(archive, 'w') do |zipfile|
        Dir["#{"clone"}/**/**"].reject{|f|f==archive}.each do |file|
          zipfile.add(file.sub("clone"+'/',''),file)
        end
      end
    end

    def move_to_archive(commit)
      `mv #{commit}.zip ./archive`
    end
  end
end
