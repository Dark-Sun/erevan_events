class Api::V1::UsersController < ApplicationController

  respond_to :json

  skip_before_action :verify_authenticity_token

  def create
    p "-------"
    p user_params
    p "--------"
    
    if user_params[:email].blank?
       @user = User.create(user_params)
       categories = UserCategory.all
       categories.each do |c|
         UserUserCategory.create(user_id: @user.id, user_category_id: c.id)
       end
    else 
      @user = User.find(user_params[:id])

      @user.update_attributes(user_params)
    end

    @user.log_in
    p  @user.errors
  
    if !params[:user_categories_attributes].blank?
      UserUserCategory.where(user_id: user_params[:id]).destroy_all
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
    @user.log_in if @user && @user.email.nil? && @user.password.nil?
      p  @user.errors
    UserUserCategory.where(user_id: user_params[:id]).destroy_all
    if @user.apns_token
        User.where(apns_token: @user.apns_token).each { |u| u.log_out }
    end
    if user_categories_params
      user_categories_params.each do |v|
        UserUserCategory.create(user_id: @user.id, user_category_id: v[1].to_i)
      end
    end

    render json: @user.to_json(include: :sent_notifications)
  end

  def index
    @user = User.find_by_email(params[:email])
    if @user.apns_token
        User.where(apns_token: @user.apns_token).each { |u| u.log_out }
    end
    
    if @user && @user.email.nil? && @user.password.nil?
      render json:  @user.to_json(include: :sent_notifications)
    else
      auth = User.authenticate(email: login_params[:email], password: login_params[:password])
      auth.log_in
    end
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
    params.permit(:id, :email, :phone, :name, :password, :gcm_id, :apns_token, :user_categories_attributes)
  end

  def user_categories_params
      params.require(:user_categories_attributes).permit! if params[:user_categories_attributes]
  end

  def login_params
    params.permit(:email, :password)
  end

end