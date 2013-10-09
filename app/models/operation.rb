class Operation < ActiveRecord::Base

	belongs_to :document, inverse_of: :operations
	belongs_to :action
	belongs_to :product, class_name: "Catalog::Product"
	has_one :talon, class_name: "Catalog::Talon", through: :product

	validate :correct_action

	after_initialize do |operation| 
		operation.talon.action = operation.action if operation.talon.present?
	end

	def document_type_id= id
		type = Type.find id
		case type.name
		when 'issue_talons' then self.action = Action.find_by_name 'issue'
		when 'repaid_talons' then self.action = Action.find_by_name 'repaid'
		when 'products_price' then self.action = Action.find_by_name 'new_price'
		end
	end
	def talon_barcode= barcode
		talon = Catalog::Talon.find_or_initialize_by(barcode: barcode)
		self.product = talon.product
	end
	def talon_barcode
		self.talon.barcode
	end

	private

	def correct_action
		case self.action.name
		when "new_price" 
			p "new_price"
		else
			unless self.talon.valid?
				last_document = Document.where(state: State.find_by_name("write")).
				joins(:operations).where(operations: {action: self.action, talon: self.talon}).order("updated_at").last 
				document_string = " документом № #{last_document.id} #{last_document.updated_at.strftime "от %d/%m/%Y-%H:%M"}" unless last_document.nil?
				self.talon.errors.full_messages.each do |msg|
					errors[:base] << "#{msg} #{document_string}"
				end
			end
		end
	end
end