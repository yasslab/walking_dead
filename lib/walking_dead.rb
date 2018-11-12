require "walking_dead/version"
require "walking_dead/config"
require "net/http"
require "uri"

class WalkingDead
  include Enumerable

  def initialize(config)
    @config = config
  end

  def each
    cache = response_cache
    each_uri do |uri|
      cache[uri]
    end
    cache.each do |uri, res|
      next if res.code.start_with?('2')
      yield uri, res
    end
  end

  private

  def paths
    Dir.glob(@config.paths)
  end

  def each_content
    paths.each do |path|
      next unless File.file?(path)
      yield File.read(path)
    end
  end

  def each_uri
    uris = []
    each_content do |content|
      uris += URI.extract(content, @config.schemes)
    end
    uris.uniq.sort.each do |uri|
      yield uri
    end
  end

  def response_cache
    Hash.new do |hash, key|
      uri = URI.parse(key)
      Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == "https") do |http|
        hash[key] = http.request_head(uri)
      end
    end
  end
end
