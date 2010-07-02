class PagePart < ActiveRecord::Base
  
  # Default Order
  default_scope :order => 'name'
  
  # Associations
  belongs_to :page
  
  # Validations
  validates_presence_of :name, :validator_name => :page_part_name_presence
  validates_length_of :name, :maximum => 100, :validator_name => :page_part_name_length
  validates_length_of :filter_id, :maximum => 25, :allow_nil => true, :validator_name => :page_part_filter_id_length
  validates_numericality_of :id, :page_id, :allow_nil => true, :only_integer => true, :validator_name => :page_part_id_numericality
  
  object_id_attr :filter, TextFilter

  def after_initialize
    self.filter_id ||= Radiant::Config['defaults.page.filter'] if new_record?
  end

end
