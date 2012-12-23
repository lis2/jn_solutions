class Commit
  attr_accessor :created_at, :author, :sha, :message
  def initialize(created_at, author, sha, message)
    @created_at = created_at
    @author = author
    @sha = sha
    @message = message
  end
end
