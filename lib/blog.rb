require 'sinatra/base'
require 'ostruct'
require 'time'

class Blog < Sinatra::Base
  set :root, File.expand_path('../../', __FILE__)
  
  # loop through all the article files
  Dir.glob "#{root}/articles/*.md" do |file|
    # parse meta data and content from file
    meta, content = File.read(file).split("\n\n", 2)
    
    # generate a metadata object
    article = OpenStruct.new YAML.load(meta)
    
    # convert the date to a time object
    article.data = Time.parse article.date.to_s
    
    # add the content
    article.content = content
    
    # generate a slug for the url
    article.slug = File.basename(file, '.md')
    
    # set up the route
    get "/#{article.slug}" do
      erb :post, :locals => { :article => article }
    end
    
    # add article to the list
    articles << article
  end
  
  # sort by date
  articles.sort_by! { |article| article.date }
  articles.reverse!
  
  get '/' do
    erb :index
  end
end