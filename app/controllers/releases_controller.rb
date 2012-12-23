class ReleasesController < ApplicationController
  before_filter :load_github, only: :index

  def index
    load_variables
  end

  def create
    @release = Release.new(params[:release])
    if @release.save
      flash[:success] = "Release was created"
      redirect_to releases_path
    else
      load_variables
      flash[:important] = "Something is wrong"
      render :index
    end
  end

  def rebuild
    @release = Release.find(params[:id])
    GitHub.make_zip(@release.commit.sha)
    flash[:success] = "Release was rebuilt"
    redirect_to releases_path
  end

  private
  def load_variables
    @releases = Release.order("created_at DESC")
    @commits = @releases.present? ? Commit.available(@releases.first) : Commit.all
  end

  def load_github
    if GitHub.limit_exceeded?
      flash[:info] = "Github exceeded"
    else
      GitHub.load_commits
    end
  end
end
