class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  # For messaging
  acts_as_messageable
  
  # Validations
  validates :username, :presence => true, :uniqueness => true
  validates :full_name, :presence => true
  
  # Associations
  # http://stackoverflow.com/questions/30074351/how-to-obtain-different-type-of-collections-for-the-same-model-in-an-association
  # http://stackoverflow.com/questions/5294775/same-model-for-two-belongs-to-associations
  has_many :posted_jobs, class_name: 'Job', foreign_key: 'poster_id', dependent: :destroy
  has_many :working_jobs, class_name: 'Job', foreign_key: 'translator_id', dependent: :destroy
  has_many :proposals, through: :jobs
  
  # Paperclip Avatar
  has_attached_file :avatar, :styles => { :small => "100x100#", :thumbnail => "64x64#" }
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
end
