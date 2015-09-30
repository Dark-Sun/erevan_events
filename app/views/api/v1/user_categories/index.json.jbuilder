
	json.array!(@user_categories) do |category|
		json.extract! category, :id, :name, :name_ru, :name_arm
	end
