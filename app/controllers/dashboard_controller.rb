class DashboardController < ApplicationController
  before_action :authenticate_user!
  def index
  end

  def developer
    render inline: '<%= render partial: "shared/index", locals: { obj: current_user.under_develop_projects, model: ""} %>', layout: 'layouts/application'
  end
end
