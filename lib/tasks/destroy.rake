require 'logger'

import 'lib/tasks/dictionaries.rake'
import 'lib/tasks/corrs.rake'
import 'lib/tasks/objects.rake'

namespace :destroy do
  task :set_logger do
    Rake.logger = Logger.new Rake::MultiIO.new(STDOUT, File.open(File.join('tmp', 'destroy.log'), 'w'))
  end

  task :final_message, [:message] do |_,args|
    Rake.info args[:message]
  end

  task :delete_completed_tasks, [:like] do |_,args|
    manager = Arel::DeleteManager.new(Database.destination_engine)
    manager.from (Destination.s_note)
    manager.where(Destination.s_note[:object].eq(Destination::SNote::COMPLETED_TASKS))

    unless (args[:like].nil? || args[:like].empty?)
      manager
        .where(Destination.s_note[:object].eq(Destination::SNote::COMPLETED_TASKS)
          .and(Destination.s_note[:value].matches(args[:like]))
        )
    end

    Destination.execute_query(manager.to_sql).do
  end

  desc 'Запуск задачи удаления данных в базе назначения'
  task :start => [
    'destroy:set_logger',
    'source:initialize', 
    'destination:initialize',

    'objects:destroy',
    'documents:destroy',
    'dictionaries:destroy',
  ] do 

    Rake::Task['destroy:delete_completed_tasks'].invoke()
    Rake::Task['destroy:final_message'].invoke("Удаление данных в базе назначения завершено.")
  end
  
  namespace :objects do
    desc 'Запуск задачи удаления объектов в базе назначения'
    task :start => [
      'set_logger', 
      'source:initialize', 
      'destination:initialize',

      'objects:destroy',
    ] do 

      Rake::Task['destroy:delete_completed_tasks'].invoke("objects:%")
      Rake::Task['destroy:final_message'].invoke("Удаление объектов в базе назначения завершено.")
    end
    
    namespace :construction do
      desc 'Запуск задачи удаления сооружений в базе назначения'
      task :start => [
        'set_logger', 
        'source:initialize', 
        'destination:initialize',

        'objects:construction:destroy',
      ] do 

        Rake::Task['destroy:delete_completed_tasks'].invoke("objects:%")
        Rake::Task['destroy:final_message'].invoke("Удаление объектов в базе назначения завершено.")
      end
    end
    
    namespace :houses_life do
      desc 'Запуск задачи удаления жилых зданий в базе назначения'
      task :start => [
        'set_logger', 
        'source:initialize', 
        'destination:initialize',

        'objects:houses_life:destroy',
      ] do 

        Rake::Task['destroy:delete_completed_tasks'].invoke("objects:%")
        Rake::Task['destroy:final_message'].invoke("Удаление объектов в базе назначения завершено.")
      end
    end
    
    namespace :houses_unlife do
      desc 'Запуск задачи удаления нежилых зданий в базе назначения'
      task :start => [
        'set_logger', 
        'source:initialize', 
        'destination:initialize',

        'objects:houses_unlife:destroy',
      ] do 

        Rake::Task['destroy:delete_completed_tasks'].invoke("objects:%")
        Rake::Task['destroy:final_message'].invoke("Удаление объектов в базе назначения завершено.")
      end
    end

  end
  
  namespace :corrs do
    desc 'Запуск задачи удаления корреспондентов в базе назначения'
    task :start => [
      'set_logger', 
      'source:initialize', 
      'destination:initialize',

      'corrs:destroy',
    ] do 

      Rake::Task['destroy:delete_completed_tasks'].invoke("corrs:%")
      Rake::Task['destroy:final_message'].invoke("Удаление корреспондентов в базе назначения завершено.")
    end
  end

  namespace :documents do
    desc 'Запуск задачи удаления документов в базе назначения'
    task :start => [
      'set_logger', 
      'source:initialize', 
      'destination:initialize',

      'documents:destroy',
    ] do 

      Rake::Task['destroy:delete_completed_tasks'].invoke("corrs:%")
      Rake::Task['destroy:final_message'].invoke("Удаление корреспондентов в базе назначения завершено.")
    end
  end
  
  namespace :dictionaries do
    desc 'Запуск задачи удаления справочников в базе назначения'
    task :start => [
      'set_logger', 
      'source:initialize', 
      'destination:initialize',

      'dictionaries:destroy',
    ] do 

      Rake::Task['destroy:delete_completed_tasks'].invoke("dictionaries:%")
      Rake::Task['destroy:final_message'].invoke("Удаление справочников в базе назначения завершено.")
    end
  end

end

