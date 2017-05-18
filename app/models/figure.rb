class Figure <ActiveRecord::Base
  has_many :landmarks
  has_and_belongs_to_many :titles
end
