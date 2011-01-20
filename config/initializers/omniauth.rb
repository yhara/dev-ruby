Rails.application.config.middleware.use OmniAuth::Builder do  
  if (k = ENV["TWITTER_KEY"]) and (s = ENV["TWITTER_SECRET"])
    provider :twitter, k, s
  else
    puts <<-EOD
    ***************************************
    warning: twitter key/secret are not set
    ***************************************
    EOD
  end
end  
