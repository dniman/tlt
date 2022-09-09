module Rake
  class MultiIO
    def initialize(*targets)
       @targets = targets
    end

    def write(*args)
      @targets.each {|t| t.write(*args)}
    end

    def close
      @targets.each(&:close)
    end
  end

  class << self
    def logger=(logger)
      @logger = logger
    end

    def logger
      @logger
    end

    def warn(message)
      @logger.warn message
    end

    def error(message)
      @logger.error message
    end

    def info(message)
      @logger.info message
    end
  end
end

Rake.add_rakelib 'lib/tasks'
