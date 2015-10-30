ActiveAdmin.register_page 'Message' do

  page_action :send_message, method: :put do
    p "======="
    p params

    UserUserCategory.where(user_category_id: params[:categories]).each do |user_usercategory|
      next unless user_usercategory.user
      user_usercategory.user.send_gcm(params[:message], 
                        message_arm: params[:message_arm], 
                        message_ru:  params[:message_ru],
                        category:    params[:user_category])
      user_usercategory.user.send_apns(params[:message], 
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