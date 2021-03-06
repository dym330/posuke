class Group < ApplicationRecord
  validates :name, presence: true, length: { in: 1..20 }
  belongs_to :employee
  has_many :group_relationships, dependent: :destroy
  has_many :employees, through: :group_relationships

  def relationship_by?(employee)
    !!group_relationships.find { |i| i[:employee_id] == employee.id }
  end
end
