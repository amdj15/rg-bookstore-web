# encoding: utf-8

class PictureUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  process :scale => [900, 1200]

  # Create different versions of your uploaded files:
  version :thumb_min do
    process :resize_to_fit => [100, 300]
  end

  version :thumb_middle do
    process :resize_to_fit => [250, 400]
  end

  version :thumb_large do
    process :resize_to_fit => [400, 600]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.

  def filename
    if original_filename
      if model && model.read_attribute(mounted_as).present?
        model.read_attribute(mounted_as)
      else
        "#{secure_token}.#{file.extension}"
      end
    end
  end

  protected
    def secure_token
      var = :"@#{mounted_as}_secure_token"
      model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
    end

  private
    def scale(width, height)
      manipulate! do |img|
        img.combine_options do |c|
          c.resize      "#{width}x#{height}"
        end
        img
      end
    end
end
