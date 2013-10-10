class Talon::Action::Repaid < Talon::Operation
	after_initialize {|operation| operation.action = Talon::Action.find_by_name "repaid"}

	validate :correct_action
	after_validation {|operation| operation.talon.action = self.action}
	def correct_action
		errors[:base] << "Талон погашен #{get_last}" if self.talon.repaid?
		errors[:base] << "Талон не выдан" if self.talon.new?
	end
	def get_last
		last_document = Talon::Repaid.where(state: Document::State.find_by_name("write")).joins(:operations).
		where(talon_operations: {action_id: self.action.id, talon_id: self.talon.id}).order("updated_at").last
		return last_document.nil? ? "...документ не найден :(" : "документом № #{last_document.id} #{last_document.updated_at.strftime "от %d/%m/%Y-%H:%M"}"
	end
end