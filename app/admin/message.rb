ActiveAdmin.register_page 'Message' do

  page_action :send_message, method: :put do
    if params[:user_category] == ""
      UserCategory.send_gcm_to_all(params[:message])
      redirect_to :back, notice: "Message sent"
    else
      category = UserCategory.find(params[:user_category])
      category.send_gcm(params[:message])
      redirect_to :back, notice: "Message sent"
    end
  end

  content :title => "Messages" do
    render partial: 'Messages/new'
  end
end