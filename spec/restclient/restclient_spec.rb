require 'rest-client'

describe "RestClient" do
  it "RestClient" do
    response = RestClient.get("https://jsonplaceholder.typicode.com/posts/2")
    content_type = response.headers[:content_type]
    expect(content_type).to match(/application\/json/)
  end
end
