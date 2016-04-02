require 'net/http'
require 'net/https'
require 'json'
require 'yaml'
require 'uri'

module Auction
  module API
    class RuntimeError < RuntimeError ; end
    class NotFound < RuntimeError ; end
  end
end

module Auction
  module API
    def self.configuration
      if defined? @environment
        raise RuntimeError.new("not configured Auction::API for #{@environment} enviroment") unless @configuration
      else
        raise RuntimeError.new('not configured Auction::API') unless @configuration
      end
      @configuration
    end
    
    def self.load (file, env = nil)
      @environment = env.to_s if env
      config = YAML.load_file(file)
      @configuration = defined?(@environment) ? config[@environment] : config
      @configuration['sandbox'] ||= false
    end

    def self.post (path, body = {})
      url = URI(configuration['host'] + path)
      http = Net::HTTP.new(url.host, url.port)
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      response = http.post(url.path, JSON.generate(body))

      raise Auction::API::RuntimeError.new("#{response.code} - #{response.message}") unless response.code.to_i == 200
      json = JSON.parse(response.body)
      if json.has_key?('error_code') and json.has_key?('error_message')
        raise RuntimeError.new "#{json['error_code']} - #{json['error_message']}"
      end
      json
    end

    def self.put (path, body = {})
      url = URI(configuration['host'] + path)
      http = Net::HTTP.new(url.host, url.port)
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      response = http.put(url.path, JSON.generate(body))

      raise Auction::API::RuntimeError.new("#{response.code} - #{response.message}") unless response.code.to_i == 200
      json = JSON.parse(response.body)
      if json.has_key?('error_code') and json.has_key?('error_message')
        raise RuntimeError.new "#{json['error_code']} - #{json['error_message']}"
      end
      json
    end

    def self.patch (path, body = {})
      url = URI(configuration['host'] + path)
      http = Net::HTTP.new(url.host, url.port)
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      response = http.patch(url.path, JSON.generate(body))

      raise Auction::API::RuntimeError.new("#{response.code} - #{response.message}") unless response.code.to_i == 200
      json = JSON.parse(response.body)
      if json.has_key?('error_code') and json.has_key?('error_message')
        raise RuntimeError.new "#{json['error_code']} - #{json['error_message']}"
      end
      json
    end

    def self.get (path)
      url = URI.parse(URI.encode(configuration['host'] + path))
      http = Net::HTTP.new(url.host, url.port)
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      response = http.get(url.path)

      raise Auction::API::RuntimeError.new("#{response.code} - #{response.message}") unless response.code.to_i == 200
      json = JSON.parse(response.body)
      if json.has_key?('error_code') and json.has_key?('error_message')
        raise RuntimeError.new "#{json['error_code']} - #{json['error_message']}"
      end
      json
    end

    def self.delete (path, body = {})
      url = URI(configuration['host'] + path)
      http = Net::HTTP.new(url.host, url.port)
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      response = http.delete(url.path, JSON.generate(body))

      raise Auction::API::RuntimeError.new("#{response.code} - #{response.message}") unless response.code.to_i == 200
      json = JSON.parse(response.body)
      if json.has_key?('error_code') and json.has_key?('error_message')
        raise RuntimeError.new "#{json['error_code']} - #{json['error_message']}"
      end
      json
    end
  end
end
