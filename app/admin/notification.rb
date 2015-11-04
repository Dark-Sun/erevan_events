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
      li { label "Please provide time in Yerevan time zone" }
      f.input :fire_time, :as => :just_datetime_picker
    end
    actions
  end

end