class Talon::Operation < ActiveRecord::Base
	belongs_to :talon, class_name: "Catalog::Talon", validate: true
	belongs_to :document, polymorphic: true
	belongs_to :action

	def talon_barcode= barcode
		self.talon = Catalog::Talon.find_or_initialize_by(barcode: barcode)
	end
	def talon_barcode
		self.talon.barcode
	end
end