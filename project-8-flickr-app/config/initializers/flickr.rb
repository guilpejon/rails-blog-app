FLICKR = Flickr.new(
  Rails.application.credentials.flickr.api_key,
  Rails.application.credentials.flickr.api_secret
)
