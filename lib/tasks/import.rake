require 'logger'

import 'lib/tasks/dictionaries.rake'
import 'lib/tasks/objects.rake'

namespace :import do
  task :set_logger do
    Rake.logger = Logger.new Rake::MultiIO.new(STDOUT, File.open(File.join('tmp', 'import.log'), 'w'))
  end

  task :final_message, [:message] do |_,args|
    Rake.info args[:message]
  end

  desc 'Запуск задачи импорта данных в базу назначения'
  task :start => [
    'set_logger', 
    'source:initialize', 
    'destination:initialize',

    'dictionaries:import',
    'objects:import',
  ] do

    Rake::Task['import:final_message'].invoke("Импорт данных в базу назначения завершен.")
  end
  
  namespace :dictionaries do
    desc 'Запуск задачи импорта справочников в базу назначения'
    task :start => [
      'set_logger', 
      'source:initialize', 
      'destination:initialize',

      'dictionaries:import',
    ] do 
    
      Rake::Task['import:final_message'].invoke("Импорт справочников в базу назначения завершен.")
    end
  end
 
  namespace :objects do
    desc 'Запуск задачи импорта объектов в базу назначения'
    task :start => [
      'set_logger', 
      'source:initialize', 
      'destination:initialize',

      'objects:import',
    ] do 

      Rake::Task['import:final_message'].invoke("Импорт объектов в базу назначения завершен.")
    end
    
    namespace :construction do
      desc 'Запуск задачи импорта сооружений в базу назначения'
      task :start => [
        'set_logger', 
        'source:initialize', 
        'destination:initialize',

        'objects:construction:import',
      ] do 

        Rake::Task['import:final_message'].invoke("Импорт объектов в базу назначения завершен.")
      end
    end
  end
end

