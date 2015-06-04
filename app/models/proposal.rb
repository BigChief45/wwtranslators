class Proposal < ActiveRecord::Base
    
    # Associations
    belongs_to :job
    belongs_to :user
    
    # Validations
    validates :content, :presence => true
end
