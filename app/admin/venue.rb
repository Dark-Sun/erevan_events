ActiveAdmin.register Venue do

  menu priority: 1

  config.filters = false

  permit_params :name, :fb_page, :address, :phone, :longtitude, :latitude, :photo

  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs do
      f.input :name
      f.input :fb_page
      f.input :phone
      f.input :longtitude, as: :hidden
      f.input :latitude, as: :hidden
      li do
        f.label 'Location'
        render 'shared/map'
      end
      f.input :address
      f.input :photo, :as => :file, :hint => f.object.photo.present? \
              ? image_tag(f.object.photo.url(:medium))
            : content_tag(:span, "no photo yet")
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
      image_tag v.photo.url(:thumb)
    end
    column :created_at
    actions
  end

  show title: :name do |v|
    attributes_table do
      row :name
      row :fb_page
      row :phone
      row :address
      row :location do
        image_tag "https://maps.googleapis.com/maps/api/staticmap?center=#{v.latitude},#{v.longtitude}&zoom=15&size=600x300&maptype=roadmap
&markers=color:red%7C#{v.latitude},#{v.longtitude}"
      end
      row :photo do 
        image_tag v.photo.url(:original), width: 600
      end
    end
  end

end
