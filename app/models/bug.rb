class Bug < ApplicationRecord

  has_one_attached :screenshot

  belongs_to :user

  has_many :project_bugs, dependent: :destroy
  has_many :infected_projects, through: :project_bugs, :source => :project

  enum nature: {
    bug: 0,
    feature: 1
  }

  enum status: [
    :new,
    :started,
    :resolved,
    :completed
  ], _suffix: true
end
