ActiveAdmin.register UserCategory do

permit_params :name, :name_arm, :name_ru

config.filters = false

end
