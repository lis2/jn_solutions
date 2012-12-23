class Release < ActiveRecord::Base
  has_one :commit
end
