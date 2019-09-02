require 'cgi'

class UrlParser
  def initialize(url)
    @url = url
    @scheme = GetScheme()
    @domain = GetDomain()
    @port = GetPort()
    @path = GetPath()
    @query_string = GetQueryString()
    @fragment_id = GetFragment()
  end
  attr_accessor :url
  attr_accessor :scheme
  attr_accessor :domain
  attr_accessor :port
  attr_accessor :path
  attr_accessor :query_string
  attr_accessor :fragment_id

  def GetScheme
    @url.split(":")[0]
  end
  def GetDomain
    @url.split("//")[1].split("/")[0].split(":")[0]
  end
  def GetPort
    scheme = @url.split(":")[0]
    port = @url.split("//")[1].split("/")[0].split(":")[1]
    if(!port and scheme == "http")
      port = "80"
    end
    if(!port and scheme == "https")
      port = "443"
    end
    port
  end
  def GetPath
    path = @url.split("//")[1].split("/")[1].split("?")[0]
    if path == "" 
      path = nil 
    end
    path
  end
  def GetQueryString
    query = @url.split("?")[1]
    if(query)
      query = query.split("#")[0]
    end
    if(query)
      CGI::parse(query).transform_values(&:last)
    else
      nil
    end
  end
  def GetFragment
    @url.split("#")[1]
  end
end