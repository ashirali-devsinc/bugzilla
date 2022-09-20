class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create :enroll_in_state_machine, :if => Proc.new{ self.developer? }

  has_many :created_projects, :class_name => "Project", :foreign_key => "creator_id"
  has_many :changes_made, :class_name => "ManualStateMachine"

  has_many :project_developers, dependent: :destroy
  has_many :under_develop_projects, through: :project_developers, :source => :project

  has_many :project_qas, dependent: :destroy
  has_many :under_test_projects, through: :project_qas, :source => :project

  has_many :bugs, dependent: :destroy

  enum user_type: {
    manager: 0,
    developer: 1,
    QA: 2
  }

  private

  def enroll_in_state_machine
    ManualStateMachine.create(user_id: self.id, model: "Bug", changes_made: [])
    ManualStateMachine.create(user_id: self.id, model: "Project", changes_made: [])
  end
end
