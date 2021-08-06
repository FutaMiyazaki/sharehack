require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
  if Rails.env.production?
    config.cache_storage = :fog
    config.fog_directory = 'sharehack-bucket'
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
      region: 'ap-northeast-1'
    }
  else
    config.cache_storage = :fog
    config.fog_directory = 'sharehack-bucket'
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: 'AKIAYVGY7HKWZSL4FCJ4',
      aws_secret_access_key: '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',
      region: 'ap-northeast-1'
    }
  end
end
