# frozen_string_literal: true

class WorkloadPolicy < ApplicationPolicy
  delegate :developer?, to: :user
  
  alias assign_bug_to_dev? developer?
  alias remove_bug_from_dev? developer?
  alias change_status? developer?
end
