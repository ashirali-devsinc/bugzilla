class Workload < ApplicationRecord
  belongs_to :bug
  belongs_to :user
  belongs_to :project

  enum status: {
    generated: 0,
    started: 1,
    resolved: 2,
    completed: 3
  }
end
