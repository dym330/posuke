class Group < ApplicationRecord
  validates :name, presence: true, length: { in: 1..20 }
  belongs_to :employee
  has_many :group_relationships
end
