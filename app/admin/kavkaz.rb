ActiveAdmin.register_page 'Kavkaz' do
  
  menu false

  content :title => "Kavkaz" do
    render partial: 'kavkaz/index'
  end

end