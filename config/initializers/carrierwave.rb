 CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',                        # required
    :aws_access_key_id      => 'AKIAJA24JJUKFLQDIC5Q',                        # required
    :aws_secret_access_key  => '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'
	}
  config.fog_directory  = 'weeverse'                  # required
  config.fog_public     = false                                   # optional, defaults to true
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
  config.fog_authenticated_url_expiration = 86400
end