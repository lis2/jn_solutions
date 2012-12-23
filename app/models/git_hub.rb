class GitHub
  def initialize
    load_commits
  end

  private
  def load_commits
    response = HTTParty.get("https://api.github.com/repos/#{JnSolutions::Application.config.git_hub}/commits") 
    response.each do |commit|
      Commit.create(commit_created_at: commit['commit']['committer']['date'],
                    author: commit['author']['login'],
                    sha: commit['sha'], 
                    message: commit['commit']['message'])
    end
  end
end
