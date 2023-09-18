describe "RestClient" do
  # it "RestClient" do
  #   response = RestClient.get("https://jsonplaceholder.typicode.com/posts/2")
  #   content_type = response.headers[:content_type]
  #   expect(content_type).to match(/application\/json/)
  # end

  # it "Makes a test using web-mock" do
  #   # Webmock wont make a real request. Just a stub one
  #   stub_request(:get, "https://jsonplaceholder.typicode.com/posts/2")
  #     .to_return(status: 200, body: "", headers: { "content-type": "application/json" })
  #     # Above im creating the stube

  #    response = RestClient.get("https://jsonplaceholder.typicode.com/posts/2")
  #   content_type = response.headers[:content_type]
  #   expect(content_type).to match(/application\/json/)
  # end

  it "makes a test using vcr" do
    VCR.use_cassette("jsonplaceholder/post") do # net time you call this vcr it wont be necessary acess the http request because it will be stored in fixtures folder
      response = RestClient.get("https://jsonplaceholder.typicode.com/posts/2")
      content_type = response.headers[:content_type]
      expect(content_type).to match(/application\/json/)
    end
  end

  it "makes a test using vcr with simples configuration", :vcr do # using this way the vcr will name the files, not you. Each teste you make will have a new vcr
    response = RestClient.get("https://jsonplaceholder.typicode.com/posts/2")
    content_type = response.headers[:content_type]
    expect(content_type).to match(/application\/json/)
  end

  it "makes a test using vcr with simples configuration chosing the vcr name", vcr: {cassette_name: "jsonplaceholder/post"} do
    response = RestClient.get("https://jsonplaceholder.typicode.com/posts/2")
    content_type = response.headers[:content_type]
    expect(content_type).to match(/application\/json/)
  end

  it "test using vcr only matchin body", vcr: {cassette_name: "jsonplaceholder/post", match_requests_on: [:body]} do
    # In this case you can alter the url and the vcr will not present a problem. You will match only the body, not the url.
    response = RestClient.get("https://jsonplaceholder.typicode.com/posts/3")
    content_type = response.headers[:content_type]
    expect(content_type).to match(/application\/json/)
  end

  it "new vcr for eah url", vcr: {cassette_name: "jsonplaceholder/post", :record => :new_episodes } do
    # In this case each new url will create a new vcr. Other types are: :none, :once, :all, :new_episodes
    response = RestClient.get("https://jsonplaceholder.typicode.com/posts/5")
    content_type = response.headers[:content_type]
    expect(content_type).to match(/application\/json/)
  end
end
