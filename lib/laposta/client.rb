require 'uri'
require 'http'
require 'json'
require_relative 'client/accounts.rb'
require_relative 'client/campaigns.rb'
require_relative 'client/fields.rb'
require_relative 'client/lists.rb'
require_relative 'client/login.rb'
require_relative 'client/reports.rb'
require_relative 'client/subscribers.rb'
require_relative 'client/webhooks.rb'
require_relative 'error'
require_relative 'version'

module Laposta
  class Client

    include Laposta::Client::Accounts
    include Laposta::Client::Campaigns
    include Laposta::Client::Fields
    include Laposta::Client::Lists
    include Laposta::Client::Login
    include Laposta::Client::Reports
    include Laposta::Client::Subscribers
    include Laposta::Client::Webhooks

    def initialize(options={})
      auth_token = options[:auth_token]
      user_agent = options[:user_agent] || "Laposta Ruby Gem #{VERSION}"
      @headers = HTTP.basic_auth(user: auth_token, pass: '')
                     .headers({
                       Accept: "application/json",
                       "User-Agent": user_agent,
                       "Content-Type": "application/x-www-form-urlencoded"
                     })
    end

    def list(path, params = {})
      query = format_query(params)
      url = "#{base_url}#{path}?#{query}"
      res = @headers.get(url)
      if !res.status.success?
        raise Error.from_response(res)
      end
      JSON.parse(res.to_s)
    end

    def get(path)
      res = @headers.get("#{base_url}#{path}")
      if !res.status.success?
        raise Error.from_response(res)
      end
      JSON.parse(res.to_s)
    end

    def get_plain(path)
      headers_copy = @headers.dup
      res = @headers.accept("text/plain").get("#{base_url}#{path}")
      if !res.status.success?
        raise Error.from_response(res)
      end
      res.to_s
    end

    def get_raw(path)
      headers_copy = @headers.dup
      res = @headers.get("#{base_url}#{path}")
      if !res.status.success?
        raise Error.from_response(res)
      end
      res
    end

    def create(path, body)
      res = @headers.post("#{base_url}#{path}", body: format_query(flatten_hash(body)))
      response = JSON.parse(res.to_s)
      if !res.status.success?
        raise Error.from_response(res)
      end
      response
    end

    def create_without_response(path, body)
      res = @headers.post("#{base_url}#{path}", body: format_query(flatten_hash(body)))
      if !res.status.success?
        raise Error.from_response(res)
      end
    end

    def update(path, body)
      res = @headers.post("#{base_url}#{path}", body: format_query(flatten_hash(body)))
      response = JSON.parse(res.to_s)
      if !res.status.success?
        raise Error.from_response(res)
      end
      response
    end

    def delete(path, body)
      res = @headers.delete("#{base_url}#{path}", body: format_query(flatten_hash(body)))
      response = JSON.parse(res.to_s)
      if !res.status.success?
        raise Error.from_response(res)
      end
      response
    end

  private
    def format_query(params)
      p = URI::Parser.new
      res = []
      if params.is_a?(Hash)
        res << params.map do |k, v|
          case v
          when Hash
            v.map { |nk, nv| "#{k}[#{nk}]=#{p.escape(nv.to_s)}" }.join("&")
          when Symbol, String
            "#{k}=#{p.escape(v)}"
          when Array then
            v.map { |c| "#{k}[]=#{p.escape(c.to_s)}" }.join("&")
          else
            "#{k}=#{p.escape(v.to_s)}"
          end
        end
      end
      res.join("&")
    end

    def flatten_hash(params)
      res = {}
      if params.is_a?(Hash)
        params.each do |k, v|
          case v
          when Hash
            v.each { |nk, nv| res["#{k}[#{nk}]"] = nv }
          else
            res[k] = v
          end
        end
      end
      res
    end

    def base_url
      "https://api.laposta.nl/v2/"
    end

  end
end
