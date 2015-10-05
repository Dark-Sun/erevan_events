
	json.array!(@user_categories) do |category|
		json.extract! category, :id, :name, :name_arm, :name_ru
	end
