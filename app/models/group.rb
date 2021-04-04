class Group < ApplicationRecord
  belongs_to :employee
  has_many :group_relationships
end
