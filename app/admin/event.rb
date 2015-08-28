ActiveAdmin.register Event do
  config.filters = false

  menu priority: 2

  permit_params :venue_id, :name, :time_date, :time_time_hour, :time_time_minute, :photo

  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs do
      f.input :venue
      f.input :name
      f.input :time, :as => :just_datetime_picker
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
    column :venue
    column :time
    column do |e|
      image_tag e.photo.url(:thumb)
    end
    column :created_at
    actions
  end

  show title: :name do |e|
    attributes_table do
      row :id
      row :venue
      row :name
      row :time
      row :photo do 
        image_tag e.photo.url(:original), width: 600
      end
      row :created_at
    end
  end


end
