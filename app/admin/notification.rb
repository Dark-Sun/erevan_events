ActiveAdmin.register Notification do

  config.filters = false

  actions :all, except: [:edit, :destroy]

  permit_params :event_id, :message, :message_armenian, :message_russian,
  :fire_time_date, :fire_time_time_hour, :fire_time_time_minute, :categories

  controller do
    def create

      @notification = Notification.new(permitted_params[:notification])

      user_ids = []
      UserUserCategory.where(user_category_id: params[:categories]).each do |user_usercategory|
        next unless user_usercategory.user
        user_ids << user_usercategory.user.id 
      end

      user_ids.uniq.each do |user_id|
        user = User.find(user_id)
        next unless user
        @notification.users << user

          # user.send_gcm(params[:message], 
          #                   message_arm: params[:message_arm], 
          #                   message_ru:  params[:message_ru],
          #                   category:    params[:user_category])
          # user.send_apns(params[:message], 
          #                   message_arm: params[:message_arm], 
          #                   message_ru:  params[:message_ru],
          #                   category:    params[:user_category])
      end

      if @notification.save
        redirect_to admin_notification_path(@notification), notice: "Success"
      else
        render :new, error: "Error happened"
      end

    end
  end

  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs do
      render partial: 'notifications/new_categories'
      f.input :event
      f.input :message
      f.input :message_armenian
      f.input :message_russian
      f.input :fire_time, :as => :just_datetime_picker
    end
    actions
  end

  #  page_action :send_message, method: :put do
  #   p "======="
  #   p params

  #   user_ids = []
  #   UserUserCategory.where(user_category_id: params[:categories]).each do |user_usercategory|
  #     next unless user_usercategory.user
  #     user_ids << user_usercategory.user.id 
  #   end

  #   user_ids.uniq.each do |user_id|
  #     user = User.find(user_id)
  #     next unless user
  #     user.send_gcm(params[:message], 
  #                       message_arm: params[:message_arm], 
  #                       message_ru:  params[:message_ru],
  #                       category:    params[:user_category])
  #     user.send_apns(params[:message], 
  #                       message_arm: params[:message_arm], 
  #                       message_ru:  params[:message_ru],
  #                       category:    params[:user_category])
  #   end


  #   redirect_to :back, notice: "Message sent"
  # end

end