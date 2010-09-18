service :tickish do |data, payload|
  commit  = payload['commits'][-1]
  api_key = data['apikey']
  
  data = {
    :author  => commit['author']['name'],
    :email   => commit['author']['email'],
    :cid     => commit['id'],
    :message => commit['message'],
    :url     => commit['url']
  }
  Net::HTTP.post_form(URI.parse("http://tickish.com/api/#{api_key}/commit"), data)
end
