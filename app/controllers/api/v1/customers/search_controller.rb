class Api::V1::Customers::SearchController < ApplicationController

  def show
    render json: Customer.find_by(valid_search_parameters)
  end

  def index
    render json: Customer.where(valid_search_parameters)
  end


  private
  def valid_search_parameters
    params.permit(:first_name, :last_name, :create_at, :updated_at)
  end
end