class WalkingDead
  class Config
    def initialize(options)
      @options = options
    end

    def paths
      @options.fetch("paths")
    end

    def schemes
      ["http", "https"]
    end
  end
end
