class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :created_projects, :class_name => "Project", :foreign_key => "creator_id"

  has_many :project_developers, dependent: :destroy
  has_many :under_develop_projects, through: :project_developers, :source => :project

  has_many :project_qas, dependent: :destroy
  has_many :under_test_projects, through: :project_qas, :source => :project

  has_many :bugs

  enum user_type: {
    manager: 0,
    developer: 1,
    QA: 2
  }
end
