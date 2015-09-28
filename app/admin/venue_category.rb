ActiveAdmin.register VenueCategory do
  config.filters = false

  menu priority: 1

  permit_params :name, :name_arm, :name_ru, :image

   form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs do
      f.input :name
      f.input :name_arm
      f.input :name_ru
      f.input :image, :as => :file, :hint => f.object.image.present? \
              ? image_tag(f.object.image.url(:thumb))
            : content_tag(:span, "no photo yet")
    end
    actions
  end

  index do
    selectable_column
    column :id
    column :name
    column do |c|
      image_tag c.image.url(:original) if c.image.present?
    end
    actions
  end

  show title: :name do |c|
    attributes_table do 
      row :id
      row :name
      row :name_arm
      row :name_ru
      row :image do 
        image_tag c.image.url(:original) if c.image.present?
      end
    end
  end

end
