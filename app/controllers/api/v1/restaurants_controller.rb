class Api::V1::RestaurantsController < Api::V1::BaseController
  before_action :set_restaurant, only: [:show, :update]
  acts_as_token_authentication_handler_for User, except: [:index, :show]

  def index
    @restaurants = policy_scope(Restaurant)
  end

  def show
    # @restaurant is accessible here because I have before_action
  end

  def update
    if @restaurant.update(restaurant_params)
      render :show
    else
      render_error
    end
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
    authorize @restaurant # For Pundit
  end

  def render_error
    render json: { errors: @restaurant.errors.full_messages },
    status: :unprocessable_entity
  end
end