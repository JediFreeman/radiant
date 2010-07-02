class Layout < ActiveRecord::Base
  
  # Default Order
  default_scope :order => "name"

  # Associations
  has_many :pages
  belongs_to :created_by, :class_name => 'User'
  belongs_to :updated_by, :class_name => 'User'

  # Validations
  validates_presence_of :name, :validator_name => :layout_name_presence
  validates_uniqueness_of :name, :validator_name => :layout_name_uniqueness
  validates_length_of :name, :maximum => 100, :validator_name => :layout_name_length
end
