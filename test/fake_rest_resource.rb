class FakeRestResource
  attr_accessor :url
  attr_accessor :options
  attr_accessor :result
  attr_accessor :get_params

  def initialize(url, options={})
    @url = url
    @options = options
  end

  def [](path)
    FakeRestResource.new("#{@url}#{path}", @options)
  end

  def get(options=nil)
    @get_params = options[:headers][:params] rescue nil
    result
  end

  [:put, :post, :patch, :delete].each do |name|
    attr_accessor :"#{name}_payload"
    attr_accessor :"#{name}_params"

    define_method(name.to_s) do |payload=nil, options=nil|
      params = options[:headers][:params] rescue nil

      instance_variable_set("@#{name}_payload", payload)
      instance_variable_set("@#{name}_params", params)
      result
    end
  end
end

