class Project < ApplicationRecord

  belongs_to :creator, :class_name => "User"

  has_many :project_developers, dependent: :destroy
  has_many :developers, through: :project_developers, :source => :user

  has_many :project_qas, dependent: :destroy
  has_many :qas, through: :project_qas, :source => :user

  has_many :project_bugs, dependent: :destroy
  has_many :bugs, through: :project_bugs

  validates :title, :description, presence: true

end
