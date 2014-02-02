class GithubAuthor < Author

  def self.client
    @client = Octokit::Client.new :client_id => ENV["GITHUB_CLIENT_ID"], :client_secret => ENV["GITHUB_CLIENT_SECRET"]
  end
end
