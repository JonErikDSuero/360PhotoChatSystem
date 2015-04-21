class Visual::Image

  include Mongoid::Document

  field :account_api_user_name, type: String
  field :account_id, type: String
  field :type, type: String

  attr_accessor :image, :image_cache

  mount_uploader :image, ImageUploader


  def delete_with_image!
    dir_path = "#{Rails.root}/public/#{self.image.store_dir}"
    self.remove_image!

    if Dir["#{dir_path}/*"].empty?
      FileUtils.remove_dir(dir_path, force: true)
    end

    self.delete
  end

end

