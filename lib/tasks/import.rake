require 'logger'

import 'lib/tasks/dictionaries.rake'
import 'lib/tasks/corrs.rake'
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
    'corrs:import',
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
  
  namespace :documents do
    desc 'Запуск задачи импорта документов в базу назначения'
    task :start => [
      'set_logger', 
      'source:initialize', 
      'destination:initialize',

      'documents:import',
    ] do 

      Rake::Task['import:final_message'].invoke("Импорт документов в базу назначения завершен.")
    end
  end
  
  namespace :corrs do
    desc 'Запуск задачи импорта корреспондентов в базу назначения'
    task :start => [
      'set_logger', 
      'source:initialize', 
      'destination:initialize',

      'corrs:import',
    ] do 

      Rake::Task['import:final_message'].invoke("Импорт кореспондентов в базу назначения завершен.")
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
    
    namespace :houses_life do
      desc 'Запуск задачи импорта жилых зданий в базу назначения'
      task :start => [
        'set_logger', 
        'source:initialize', 
        'destination:initialize',

        'objects:houses_life:import',
      ] do 

        Rake::Task['import:final_message'].invoke("Импорт объектов в базу назначения завершен.")
      end
    end
    
    namespace :houses_unlife do
      desc 'Запуск задачи импорта нежилых зданий в базу назначения'
      task :start => [
        'set_logger', 
        'source:initialize', 
        'destination:initialize',

        'objects:houses_unlife:import',
      ] do 

        Rake::Task['import:final_message'].invoke("Импорт объектов в базу назначения завершен.")
      end
    end

    namespace :life_room do
      desc 'Запуск задачи импорта жилых помещений в базу назначения'
      task :start => [
        'set_logger', 
        'source:initialize', 
        'destination:initialize',

        'objects:life_room:import',
      ] do 

        Rake::Task['import:final_message'].invoke("Импорт объектов в базу назначения завершен.")
      end
    end
    
    namespace :unlife_room do
      desc 'Запуск задачи импорта нежилых помещений в базу назначения'
      task :start => [
        'set_logger', 
        'source:initialize', 
        'destination:initialize',

        'objects:unlife_room:import',
      ] do 

        Rake::Task['import:final_message'].invoke("Импорт объектов в базу назначения завершен.")
      end
    end
    
    namespace :unfinished do
      desc 'Запуск задачи импорта объектов незавершенного строительства в базу назначения'
      task :start => [
        'set_logger', 
        'source:initialize', 
        'destination:initialize',

        'objects:unfinished:import',
      ] do 

        Rake::Task['import:final_message'].invoke("Импорт объектов в базу назначения завершен.")
      end
    end

  end
end

