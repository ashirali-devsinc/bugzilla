# frozen_string_literal: true

class BugPolicy < ApplicationPolicy
  delegate :QA?, to: :user

  alias index? QA?
  alias new? QA?
  alias edit? QA?
  alias create? QA?
  alias update? QA?
  alias destroy? QA?
  alias remove? QA?
  alias assign? QA?
end
