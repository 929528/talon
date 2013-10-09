namespace :db do
	desc "Initialize db"
	task init: :environment do
		org = Catalog::Organization.new name: "ООО Белком", fullname: "Общество с ограниченной ответственностью \"Белком\""
		org.departments.build name: "Трактора"
		org.departments.build name: "Жуки"
		org.departments.build name: "Высокий"
		org.save!
		Catalog::User.create!(name: "oleg", 
			password: "9700477", 
			password_confirmation: "9700477", 
			email: "929528@gmail.com",
			department: Catalog::Department.find_by_name("Трактора"))
		Talon::State.create!(name: "new")
		Talon::State.create!(name: "issued")
		Talon::State.create!(name: "repaid")
		Talon::Action.create!(name: "issue")
		Talon::Action.create!(name: "repaid")
		Document::State.create!(name: "new")
		Document::State.create!(name: "save")
		Document::State.create!(name: "write")
		Talon::Amount.create!(value: "20", symbol: "2")
		Talon::Amount.create!(value: "5", symbol: "5")
		Catalog::Product.create!(name: "А-92", fullname: "Бензин автомобильный А-92", symbol: "4")
		Catalog::Product.create!(name: "А-95", fullname: "Бензин автомобильный А-95", symbol: "5")
		Catalog::Product.create!(name: "Аб-92", fullname: "Биоэтанол автомобильный Аб-92", symbol: "3")
		Catalog::Product.create!(name: "ДТ", fullname: "Топливо дизельное", symbol: "2")
		Catalog::Product.create!(name: "Газ", fullname: "Газ углеводородный", symbol: "1")
		p "ALL DONE !"
	end
end