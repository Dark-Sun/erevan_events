
	json.array!(@user_categories) do |category|
		json.extract! category, :id, :name
	end
