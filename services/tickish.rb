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
  
  # The data hash is only being send to the Tickish server if the commit message contains an issue id
  Net::HTTP.post_form(URI.parse("http://tickish.com/api/#{api_key}/commit"), data) if commit['message'].match(/#(\d+)\s*$/)
end
