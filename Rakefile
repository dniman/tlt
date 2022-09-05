module Rake
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
