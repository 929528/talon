class Talon::Operation < ActiveRecord::Base
	belongs_to :talon, class_name: "Catalog::Talon", validate: true
	belongs_to :document, polymorphic: true
	belongs_to :action

	validate :correct_action
	after_validation {|operation| operation.talon.action = self.action}

	def talon_barcode= barcode
		self.talon = Catalog::Talon.find_or_initialize_by(barcode: barcode)
	end
	def talon_barcode
		self.talon.barcode
	end

	private

	def correct_action
		errors[:base] << "Талон уже выдан #{get_last Talon::Issue}" if self.action.issue? && self.talon.issued?
		errors[:base] << "Талон уже погашен #{get_last Talon::Repaid}" if self.action.repaid? && self.talon.repaid?
		errors[:base] << "Талон еще не выдан" if self.action.repaid? && self.talon.new?
	end
	def get_last document_class
		last_document = document_class.where(state: Document::State.find_by_name("write")).joins(:operations).
		where(talon_operations: {action_id: self.action.id, talon_id: self.talon.id}).order("updated_at").last
		string = " документом № #{last_document.id} #{last_document.updated_at.strftime "от %d/%m/%Y-%H:%M"}"
	end
end