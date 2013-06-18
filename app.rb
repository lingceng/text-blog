require 'builder'
require 'sinatra'
$LOAD_PATH << File.dirname(__FILE__)+"/lib"
require 'article'

# like some initial
configure do
  Article.load(File.dirname(__FILE__)+"/articles")
end

# like some function
helpers do
  def archives
    Article.articles
  end

  def articles
    Article.articles
  end
end

set :views, File.dirname(__FILE__)+'/templates'
set :title => "Lingceng's blog"

get '/' do
  erb :"pages/index", :locals => { 
    :title => settings.title
  }
end

get "/index.xml" do
  @config = {}
  builder :index
end

get '/:year/:month/:day/:slug' do |year, month, day, slug|
  @config = {}
  article = Article["#{year}-#{month}-#{day}-#{slug}"]

  # pass to the next matching route unless article
  pass unless article

  erb :"pages/article", :locals => article.to_hash
end

get "/archives" do
  erb :"pages/archives", :locals => { :title => settings.title }
end
