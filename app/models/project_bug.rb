class ProjectBug < ApplicationRecord
  belongs_to :bug
  belongs_to :project
end
