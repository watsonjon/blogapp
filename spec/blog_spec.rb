require 'blog'
require 'sinatra'
require 'rspec'
require 'rack/test'

# require 'sinatra' to set these
set :environment, :test
set :run, false
set :raise_errors, true
set :logging, false

# would be Sinatra::Application for 'classic' style
def app
  Blog
end

describe "The Blog App" do
  include Rack::Test::Methods
  
  context "when launching the app" do
    it "returns the default page" do
      get '/' do
        last_response.should be_ok
        last_response.should match(/My Blog/)
      end
    end
  end
end