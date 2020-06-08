class ImageUploader < CarrierWave::Uploader::Base
  # developmentとtest以外はS3を使用
  if Rails.env.development?
    storage :fog
  elsif Rails.env.test?
    storage :file
  else
    storage :fog
  end

  # 画像ごとに保存するディレクトリを変える
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{model.id}/#{mounted_as}"
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  def filename
    original_filename if original_filename
  end
end