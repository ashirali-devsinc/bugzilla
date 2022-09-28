# frozen_string_literal: true

class ProjectPolicy < ApplicationPolicy
  delegate :manager?, to: :user

  def index?
    user.manager? || user.QA?
  end
  alias new? manager?
  alias edit? manager?
  alias create? manager?
  alias update? manager?
  alias destroy? manager?
  alias assign_dev? manager?
  alias assign_qa? manager?
  alias remove_dev? manager?
  alias remove_qa? manager?
end
