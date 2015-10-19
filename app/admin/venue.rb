ActiveAdmin.register Venue do

  menu priority: 2

  config.filters = false

  permit_params :name, :name_arm, :name_ru, :fb_page, :address, :phone, :longitude, :latitude, 
                :photo, :from_facebook, :description, :description_arm, :description_ru, :cover, 
                :venue_category_id

  collection_action :new_from_facebook, method: :get do
    session[:new_venue_from_facebook] = true
    redirect_to new_admin_venue_path
  end

  action_item do
    link_to "New Venue from Facebook", new_from_facebook_admin_venues_path
  end
  
  member_action :sync_with_facebook do
    if GetVenueEventsWorker.perform_async(params[:id])
      redirect_to :back, notice: "Action is scheduled"
    else
      redirect_to :back, notice: "Oops, something went wrong :("
    end
  end

  action_item :only => :show do
    link_to "Update events from Facebook", sync_with_facebook_admin_venue_path(params[:id])
  end


  form :html => { :enctype => "multipart/form-data" } do |f|
    if session[:new_venue_from_facebook] == true || f.object.errors["fb_page"].any? # fb_page contains errors only if record is created from facebook page
      session[:new_venue_from_facebook] = false
      f.inputs do
        f.input :from_facebook, as: :hidden, :input_html => { :value => "true" }
        f.input :venue_category, include_blank: false
        f.input :fb_page, placeholder: 'https://www.facebook.com/salonarmenian'
      end
    else
      f.inputs do
        f.input :name
        f.input :name_arm
        f.input :name_ru
        f.input :venue_category
        f.input :description, as: :text
        f.input :description_arm, :as => :text
        f.input :description_ru, :as => :text
        f.input :fb_page
        f.input :phone
        f.input :longitude, as: :hidden
        f.input :latitude, as: :hidden
        li do
          f.label 'Location'
          render 'shared/map'
        end
        f.input :address
        f.input :photo, :as => :file, :hint => f.object.photo.present? \
                ? image_tag(f.object.photo.url(:medium))
              : content_tag(:span, "no photo yet")
        f.input :cover, :as => :file, :hint => f.object.cover.present? \
                ? image_tag(f.object.cover.url(:medium))
              : content_tag(:span, "no cover yet")
      end
    end
    actions
  end

  index do
    selectable_column
    column :id
    column :name
    column :fb_page
    column :address
    column :phone
    column do |v|
      image_tag v.photo.url(:thumb) if v.photo.file?
    end
    column :created_at
    actions
  end

  show title: :name do |v|
    attributes_table do
      row :name
      row :name_arm
      row :name_ru
      row :venue_category
      row :description
      row :description_arm
      row :description_ru
      row :fb_page
      row :phone
      row :address
      row :location do
        (v.latitude.nil? && v.longitude.nil?) ? 
        "Empty" 
        :
        (image_tag "https://maps.googleapis.com/maps/api/staticmap?center=#{v.latitude},#{v.longitude}&zoom=15&size=600x300&maptype=roadmap
&markers=color:red%7C#{v.latitude},#{v.longitude}")
      end
      row :photo do 
        image_tag v.photo.url(:medium) if v.photo.file?
      end
      row :cover do
        image_tag v.cover.url(:medium) if v.cover.file?
      end
      row "Photos" do |venue|
        link_to("Photos", admin_venue_venue_photos_path(venue))
      end
    end
  end

end
