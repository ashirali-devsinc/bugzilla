class Bug < ApplicationRecord

  has_one_attached :screenshot

  belongs_to :user

  has_many :project_bugs, dependent: :destroy
  has_many :infected_projects, through: :project_bugs, :source => :project

  validates :title, :nature, presence: true
  validates :title, uniqueness: true

  enum nature: {
    bug: 0,
    feature: 1
  }
end
