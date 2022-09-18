class Bug < ApplicationRecord

  belongs_to :user
  belongs_to :project

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
