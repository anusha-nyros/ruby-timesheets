class LinksController < ApplicationController
 layout 'app'
 before_filter :authorize 
 def show
    @link = Link.find_by_url(params[:url])
    raise ActionController::RoutingError.new('Not Found') unless @link
  end
end
