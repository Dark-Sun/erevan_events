ActiveAdmin.register VenuePhoto do

  # menu false

  belongs_to :venue

  config.filters = false

  index do
    selectable_column
    column :id
    column :photo_url do |photo|
      image_tag photo.thumb_url
    end
    actions
  end

  show do
    attributes_table do
      row :id
      row :venue
      row :photo_url do |photo|
        image_tag photo.photo_url, width: 600
      end
      row :created_at
      row :updated_at
    end
  end

end
