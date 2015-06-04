class Job < ActiveRecord::Base
    
    # Validations
    validates :title, :presence => true
    validates :description, :presence => true
    validates :source_language, :presence => true
    validates :target_language, :presence => true
    validate :check_languages
    
    # Attachment with Paperclip Gem
    has_attached_file :attachment
    validates_attachment_content_type :attachment, :content_type => ["application/pdf","application/vnd.ms-excel",     
             "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
             "application/msword", 
             "application/vnd.openxmlformats-officedocument.wordprocessingml.document", 
             "text/plain"]
    
    
    # Associations
    # http://stackoverflow.com/questions/30074351/how-to-obtain-different-type-of-collections-for-the-same-model-in-an-association
    # http://stackoverflow.com/questions/5294775/same-model-for-two-belongs-to-associations
    belongs_to :poster, class_name: 'User', foreign_key: 'poster_id'
    belongs_to :translator, class_name: 'User', foreign_key: 'translator_id'
    has_many :proposals, dependent: :destroy
    
    # Language Validations
    def check_languages
        if ( source_language == target_language )
            errors.add(:source_language, "cannot be the same as target language.")
            errors.add(:target_language, "cannot be the same as source language.")
        end
    end
end
