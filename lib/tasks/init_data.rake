namespace :db do
	desc "Initialize db"
	task init: :environment do
		Catalog::User.create!(name: "oleg", 
			password: "9700477", 
			password_confirmation: "9700477", 
			email: "929528@gmail.com")
		Action.create!(name: "new")
		Action.create!(name: "issue")
		Action.create!(name: "repaid")
		Catalog::State.create!(name: "new")
		Catalog::State.create!(name: "issued")
		Catalog::State.create!(name: "repaid")
		State.create!(name: "new")
		State.create!(name: "save")
		State.create!(name: "write")
		Type.create!(name: "issue_talons")
		Type.create!(name: "repaid_talons")
	end
end