class Snippet < ActiveRecord::Base
  
  # Default Order
  default_scope :order => 'name'
  
  # Associations
  belongs_to :created_by, :class_name => 'User'
  belongs_to :updated_by, :class_name => 'User'

  # Validations
  validates_presence_of :name, :validator_name => :snippet_name_presence
  validates_length_of :name, :maximum => 100, :validator_name => :snippet_name_length
  validates_length_of :filter_id, :maximum => 25, :allow_nil => true, :validator_name => :snippet_filter_id_length
  validates_format_of :name, :with => %r{^\S*$}, :validator_name => :snippet_name_format
  validates_uniqueness_of :name, :validator_name => :snippet_name_uniqueness
  
  object_id_attr :filter, TextFilter

end
