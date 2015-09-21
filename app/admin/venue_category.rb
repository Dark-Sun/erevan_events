ActiveAdmin.register VenueCategory do
  config.filters = false

  menu priority: 1

  permit_params :name, :image

   form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs do
      f.input :name
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
      image_tag c.image.url(:thumb) if c.image.present?
    end
    actions
  end

  show title: :name do |c|
    attributes_table do 
      row :id
      row :name
      row :image do 
        image_tag c.image.url(:original) if c.image.present?
      end
    end
  end

end
