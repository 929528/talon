class Talon::Action::Issue < Talon::Operation
	after_initialize {|operation| operation.action = Talon::Action.find_by_name "issue"}

	validate :correct_action
	after_validation {|operation| operation.talon.action = self.action}
	def correct_action
		errors[:base] << "Талон выдан #{get_last}" if self.talon.issued?
	end
	def get_last
		last_document = Talon::Issue.where(state: Document::State.find_by_name("write")).joins(:operations).
		where(talon_operations: {action_id: self.action.id, talon_id: self.talon.id}).order("updated_at").last
		return last_document.nil? ? "...документ не найден :(" : "документом № #{last_document.id} #{last_document.updated_at.strftime "от %d/%m/%Y-%H:%M"}"
	end
end