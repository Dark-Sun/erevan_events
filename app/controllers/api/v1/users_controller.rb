class Api::V1::UsersController < ApplicationController

  respond_to :json

  skip_before_action :verify_authenticity_token

  def create
    p "-------"
    p user_params
    p user_categories_params
    p "--------"
    @user = User.create(user_params)
      p  @user.errors
    if user_categories_params.any?
      user_categories_params.each do |v|
        UserUserCategory.create(user_id: @user.id, user_category_id: v[1].to_i)
      end
    end

    p render json: @user.to_json
  end

  def update
    p "-------"
    p user_params
    p user_categories_params
    p "--------"
    @user = User.find(user_params[:id])
      p  @user.errors
    UserUserCategory.where(user_id: user_params[:id]).destroy_all
    if user_categories_params.any?
      user_categories_params.each do |v|
        UserUserCategory.create(user_id: @user.id, user_category_id: v[1].to_i)
      end
    end

    p render json: @user.to_json
  end

  def index
    @user = User.find_by_email(params[:email])
    auth = User.authenticate(email: login_params[:email], password: login_params[:password])
    render json: auth, except: [:encrypted_password, :salt]
  end

  private

  def user_params
    params.permit(:id, :email, :phone, :name, :password, :gcm_id)
  end

  def user_categories_params
    params.require(:user_categories_attributes).permit!
  end

  def login_params
    params.permit(:email, :password)
  end

end