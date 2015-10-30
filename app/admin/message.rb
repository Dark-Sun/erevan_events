ActiveAdmin.register_page 'Message' do

  page_action :send_message, method: :put do
    p "======="
    p params

    user_ids = []
    UserUserCategory.where(user_category_id: params[:categories]).each do |user_usercategory|
      next unless user_usercategory.user
      user_ids << user_usercategory.user.id 
    end

    user_ids.uniq.each do |user_id|
      user = User.find(user_id)
      next unless user
      user.send_gcm(params[:message], 
                        message_arm: params[:message_arm], 
                        message_ru:  params[:message_ru],
                        category:    params[:user_category])
      user.send_apns(params[:message], 
                        message_arm: params[:message_arm], 
                        message_ru:  params[:message_ru],
                        category:    params[:user_category])
    end


    redirect_to :back, notice: "Message sent"
  end

  content :title => "Messages" do
    render partial: 'messages/new'
  end
end