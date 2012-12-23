require 'spec_helper'

describe ReleasesController do
  it "renders index" do
    get "index"
    response.should be_success
  end
end
