class Visual::Image

  include Mongoid::Document

  field :username, type: String
  field :user_id, type: String
  field :type, type: String

  attr_accessor :image, :image_cache

  mount_uploader :image, ImageUploader

end

