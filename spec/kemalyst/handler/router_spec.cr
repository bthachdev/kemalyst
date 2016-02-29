require "./spec_helper"

describe Kemalyst::Handler::Router do

  it "set content_type to text/html" do
    request = HTTP::Request.new("GET", "/")
    context = create_context(request)
    
    router = Kemalyst::Handler::Router.new
    router.add_route("GET", "/", 
      ->(c : HTTP::Server::Context) { "Hello World!" })
    router.call(context)
    context.response.headers["content_type"].should eq "text/html"
  end

  it "set response body to Hello World!" do
    router = Kemalyst::Handler::Router.new
    router.add_route("GET", "/", 
      ->(c : HTTP::Server::Context) { "Hello World!" })

    request = HTTP::Request.new("GET", "/")
    context = create_context(request)
    router.call(context)
    #client_response = HTTP::Client::Response.from_io(io, decompress: false)
    #client_response.body.should eq "Hello World!"
  end

  it "builds handler callstack for routes" do
    router = Kemalyst::Handler::Router.new
    router.add_route("GET", "/", 
     [Kemalyst::Handler::WebSocket.new(->(ws : HTTP::WebSocket){})], 
      ->(c : HTTP::Server::Context) { "Hello World!" })
    request = HTTP::Request.new("GET", "/")
    context = create_context(request)
    router.call(context)
    #client_response = HTTP::Client::Response.from_io(context.response.output, decompress: false)
    #client_response.body.should eq "Hello World!"
  end

  
  
end


