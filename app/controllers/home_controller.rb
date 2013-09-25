class HomeController < ApplicationController
  before_filter :authorize
  before_filter :plan_check1
  before_filter :admin_credit_check1
  before_filter :update_switches
  def index
  end
end
