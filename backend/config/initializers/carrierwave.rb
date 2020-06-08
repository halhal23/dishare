require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|  

  config.fog_credentials = {  
    provider: 'AWS',  
    aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],  
    aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],  
    region: 'ap-northeast-1'  
  }  

  config.fog_directory  = 'dishare-images'  
  config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/dishare-images'
  config.cache_storage = :fog  

end  