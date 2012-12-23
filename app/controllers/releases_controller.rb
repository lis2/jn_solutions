class ReleasesController < ApplicationController
  before_filter :load_github

  def index
    @releases = Release.all
    @commits = Commit.all
  end

  private
  def load_github
    GitHub.new
  end
end
