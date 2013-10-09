module Talon::IssueHelper
	def setup_document document
		if document.new_record?
			document.contract ||= document.build_contract
			document.contract.customer ||= document.contract.build_customer
		end
		return document
	end
end