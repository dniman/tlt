require 'securerandom'

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

    def invoke_task(task_name)
      args = []
      args.insert 0, SecureRandom.uuid.to_s 

      body = proc {
        if Destination::SNote.task_exists?(task_name)
          Rake.warn "Задача '#{ task_name }' пропущена. Выполнено ранее."
          return 
        end
        
        Rake.application.invoke_task task_name
        

        Destination::SNote.task_insert(task_name)
      }
      task = Rake::Task.define_task(*args, &body)
      task.invoke(task_name)
    end
  end
end

Rake.add_rakelib 'lib/tasks'
