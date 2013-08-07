class Pic < ActiveRecord::Base
  
  
  has_attached_file :image, styles: { medium: "320x240>"}
attr_accessible :description, :image
validates :user_id, presence: true
  validates :description, presence: true
  belongs_to :user
  validates :attachment, :attachment_content_type => { :content_type => ['image/png', 'image/jpg', 'image/gif']}, :presence => true
  
  
  
  
end

