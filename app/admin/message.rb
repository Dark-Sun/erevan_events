ActiveAdmin.register_page 'Message' do

  page_action :send_message, method: :put do
    p "======="
    p params
    params[:categories].each do |category_id|
      category = UserCategory.find(category_id)
      category.send_gcm(params[:message], 
                        message_arm: params[:message_arm], 
                        message_ru:  params[:message_ru],
                        category:    params[:user_category])
      category.send_apns(params[:message], 
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