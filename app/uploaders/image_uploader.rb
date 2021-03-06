class ImageUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    "default_icon.jpg"
  end

  # 画像の上限を640x480にする
 process :resize_to_limit => [200, 200]

 # 保存形式をJPGにする
 process :convert => 'jpg'

 # サムネイルを生成する設定
 # version :thumb do
   # process :resize_to_limit => [300, 300]
 # end

 # version :thumb100 do
   # process :resize_to_limit => [100, 100]
 # end

 version :thumb50 do
   process :resize_to_limit => [50, 50]
 end
 # @user.imagre.thum50.url で取り出せる

 # jpg,jpeg,gif,pngしか受け付けない
 def extension_white_list
   %w(jpg jpeg gif png)
 end

# 拡張子が同じでないとGIFをJPGとかにコンバートできないので、ファイル名を変更
 def filename
   super.chomp(File.extname(super)) + '.jpg' if original_filename.present?
 end

# ファイル名を日付にするとタイミングのせいでサムネイル名がずれる
#ファイル名はランダムで一意になる
 def filename
   "#{secure_token}.#{file.extension}" if original_filename.present?
 end

 protected
 def secure_token
   var = :"@#{mounted_as}_secure_token"
   model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
 end

end
