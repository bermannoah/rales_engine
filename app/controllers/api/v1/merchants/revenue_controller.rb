class Api::V1::Merchants::RevenueController < ApplicationController

  def index
    render json: Merchant.revenue_by_date(params[:date])
  end

end
