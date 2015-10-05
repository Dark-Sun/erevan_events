ActiveAdmin.register_page 'Message' do

  page_action :send_message, method: :put do
    if params[:user_category] == ""
      UserCategory.send_gcm_to_all(params[:message], 
                                   message_arm: params[:message_arm], 
                                   message_ru:  params[:message_ru])
      UserCategory.send_apns_to_all(params[:message], 
                                   message_arm: params[:message_arm], 
                                   message_ru:  params[:message_ru])
      redirect_to :back, notice: "Message sent"
    else
      category = UserCategory.find(params[:user_category])
      category.send_gcm(params[:message], 
                        message_arm: params[:message_arm], 
                        message_ru:  params[:message_ru],
                        category:    params[:user_category])
      category.send_apns(params[:message], 
                        message_arm: params[:message_arm], 
                        message_ru:  params[:message_ru],
                        category:    params[:user_category])
      redirect_to :back, notice: "Message sent"
    end
  end

  content :title => "Messages" do
    render partial: 'messages/new'
  end
end