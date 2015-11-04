class Api::V1::UsersController < ApplicationController

  respond_to :json

  skip_before_action :verify_authenticity_token

  def create
    p "-------"
    p user_params
    p "--------"
    p user_categories_params
    @user = User.create(user_params)
    @user.log_in
      p  @user.errors
    if user_categories_params
      user_categories_params.each do |v|
        UserUserCategory.create(user_id: @user.id, user_category_id: v[1].to_i)
      end
    end

    render json: @user.to_json(include: :sent_notifications)
  end

  def update
    p "-------"
    p user_params
    p user_categories_params
    p "--------"
    @user = User.find(user_params[:id])
    @user.log_in
      p  @user.errors
    UserUserCategory.where(user_id: user_params[:id]).destroy_all
    if user_categories_params.any?
      user_categories_params.each do |v|
        UserUserCategory.create(user_id: @user.id, user_category_id: v[1].to_i)
      end
    end

    render json: @user.to_json(include: :sent_notifications)
  end

  def index
    @user = User.find_by_email(params[:email])
    auth = User.authenticate(email: login_params[:email], password: login_params[:password])
    auth.log_in
    # render json: @user.to_json(include: :sent_notifications), except: [:encrypted_password, :salt]
  end

  def log_out
    @user = User.find_by_email(params[:email])
    auth = User.authenticate(email: login_params[:email], password: login_params[:password])
    if auth
      auth.log_out
      render :json => {}
    else
      render :json => {}
    end
  end

  private

  def user_params
    params.permit(:id, :email, :phone, :name, :password, :gcm_id, :apns_token)
  end

  def user_categories_params
    params.require(:user_categories_attributes).permit!
  end

  def login_params
    params.permit(:email, :password)
  end

end