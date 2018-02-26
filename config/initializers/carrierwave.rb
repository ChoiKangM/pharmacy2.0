require 'carrierwave/orm/activerecord'
if Rails.env.development?
  CarrierWave.configure do |config|
    config.fog_provider = 'fog/aws'                        # required
    config.fog_credentials = {
      provider:              'AWS',                        # required
      aws_access_key_id:     "#{ENV['AWS_KEY']}",                        # required
      aws_secret_access_key: "#{ENV['AWS_SECRET']}",                        # required
      region:                'ap-southeast-1',                  # sinagpore
  }
    config.fog_directory  = 'knup2.0-development' # development
  end
elsif Rails.env.production?
  CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'                        # required
  config.fog_credentials = {
    provider:              'AWS',                        # required
    aws_access_key_id:     "#{ENV['AWS_KEY']}",                        # required
    aws_secret_access_key: "#{ENV['AWS_SECRET']}",                        # required
    region:                'ap-northeast-2',                  # seoul
  }
    config.fog_directory  = 'knup2.0-production' # production
  end

end
