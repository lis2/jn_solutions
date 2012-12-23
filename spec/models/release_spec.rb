require 'spec_helper'

describe Release do
  it { should have_one(:commit) }
end
