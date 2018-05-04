require 'carrierwave/orm/activerecord'
if Rails.env.development?
  CarrierWave.configure do |config|
    config.fog_provider = 'fog/aws'                        # required
    config.fog_credentials = {
      provider:              'AWS',                        # required
      aws_access_key_id:     "#{ENV['AWS_KEY']}",                        # required
      aws_secret_access_key: "#{ENV['AWS_SECRET']}",                        # required
      region:                'ap-southeast-1',                  # sinagpore
      endpoint:              'https://s3-ap-southeast-1.amazonaws.com' # optional, defaults to nil
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
    endpoint:              'https://s3-ap-northeast-2.amazonaws.com' # optional, defaults to nil
  }
    config.fog_directory  = 'knup2.0-production' # production
  end

end
