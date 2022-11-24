require 'logger'

import 'lib/tasks/dictionaries.rake'
import 'lib/tasks/corrs.rake'
import 'lib/tasks/objects.rake'
import 'lib/tasks/agreements.rake'

namespace :import do
  task :set_logger do
    Rake.logger = Logger.new Rake::MultiIO.new(STDOUT, File.open(File.join('tmp', 'import.log'), 'w'))
  end

  task :final_message, [:message] do |_,args|
    Rake.info args[:message]
  end

  # Импорт всех данных
  desc 'Запуск задачи импорта данных в базу назначения'
  task :start => [
    'set_logger', 
    'source:initialize', 
    'destination:initialize',

    'dictionaries:import',
    'documents:import',
    'corrs:import',
    'objects:import',
    'agreements:import',
    'paycards:import',
    'paycardobjects:import',
  ] do

    Rake::Task['import:final_message'].invoke("Импорт данных в базу назначения завершен.")
  end
 
  # Импорт справочников
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
  
  # Импорт документов
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
  
  # Импорт корреспондентов
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
 
  # Импорт объектов
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
    
    # Импорт земельных участков
    namespace :land do
      desc 'Запуск задачи импорта земельных участков в базу назначения'
      task :start => [
        'set_logger', 
        'source:initialize', 
        'destination:initialize',

        'objects:land:import',
      ] do 

        Rake::Task['import:final_message'].invoke("Импорт объектов в базу назначения завершен.")
      end
    end
   
    # Импорт сооружений
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
    
    # Импорт инженерных сетей 
    namespace :engineering_network do
      desc 'Запуск задачи импорта инженерных сетей в базу назначения'
      task :start => [
        'set_logger', 
        'source:initialize', 
        'destination:initialize',

        'objects:engineering_network:import',
      ] do 

        Rake::Task['import:final_message'].invoke("Импорт объектов в базу назначения завершен.")
      end
    end
    
    # Импорт автомобильных дорог
    namespace :automobile_road do
      desc 'Запуск задачи импорта инженерных сетей в базу назначения'
      task :start => [
        'set_logger', 
        'source:initialize', 
        'destination:initialize',

        'objects:automobile_road:import',
      ] do 

        Rake::Task['import:final_message'].invoke("Импорт объектов в базу назначения завершен.")
      end
    end
    
    # Импорт жилых зданий
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
    
    # Импорт нежилых зданий
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

    # Импорт жилых помещений
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
    
    # Импорт нежилых помещений
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
    
    # Импорт незавершенного строительства
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

    # Импорт движимого имущества
    namespace :movable_other do
      desc 'Запуск задачи импорта иного движимого имущества в базу назначения'
      task :start => [
        'set_logger', 
        'source:initialize', 
        'destination:initialize',

        'objects:movable_other:import',
      ] do 

        Rake::Task['import:final_message'].invoke("Импорт объектов в базу назначения завершен.")
      end
    end
    
    # Импорт транспортных средств
    namespace :transport do
      desc 'Запуск задачи импорта транспортных средств в базу назначения'
      task :start => [
        'set_logger', 
        'source:initialize', 
        'destination:initialize',

        'objects:transport:import',
      ] do 

        Rake::Task['import:final_message'].invoke("Импорт объектов в базу назначения завершен.")
      end
    end
   
    # Импорт объектов интеллектуальной собственности
    namespace :exright_intellprop do
      desc 'Запуск задачи импорта объектов интеллектуальной собственности в базу назначения'
      task :start => [
        'set_logger', 
        'source:initialize', 
        'destination:initialize',

        'objects:exright_intellprop:import',
      ] do 

        Rake::Task['import:final_message'].invoke("Импорт объектов в базу назначения завершен.")
      end
    end

    # Импорт акций
    namespace :share do
      desc 'Запуск задачи импорта акций в базу назначения'
      task :start => [
        'set_logger', 
        'source:initialize', 
        'destination:initialize',

        'objects:share:import',
      ] do 

        Rake::Task['import:final_message'].invoke("Импорт объектов в базу назначения завершен.")
      end
    end
    
    # Импорт долей в уставном капитале
    namespace :partnership do
      desc 'Запуск задачи импорта долей в уставном капитале в базу назначения'
      task :start => [
        'set_logger', 
        'source:initialize', 
        'destination:initialize',

        'objects:partnership:import',
      ] do 

        Rake::Task['import:final_message'].invoke("Импорт объектов в базу назначения завершен.")
      end
    end

  end

  # Импорт договоров
  namespace :agreements do
    desc 'Запуск задачи импорта договоров в базу назначения'
    task :start => [
      'set_logger', 
      'source:initialize', 
      'destination:initialize',

      'agreements:import',
    ] do 

      Rake::Task['import:final_message'].invoke("Импорт договоров в базу назначения завершен.")
    end
  end
  
  # Импорт карточек договоров
  namespace :paycards do
    desc 'Запуск задачи импорта карточек учета договоров в базу назначения'
    task :start => [
      'set_logger', 
      'source:initialize', 
      'destination:initialize',

      'paycards:import',
    ] do 

      Rake::Task['import:final_message'].invoke("Импорт карточек учета договоров в базу назначения завершен.")
    end
  end
  
  # Импорт объектов карточек договоров
  namespace :paycardobjects do
    desc 'Запуск задачи импорта объектов карточек учета договоров в базу назначения'
    task :start => [
      'set_logger', 
      'source:initialize', 
      'destination:initialize',

      'paycardobjects:import',
    ] do 

      Rake::Task['import:final_message'].invoke("Импорт объектов карточек учета договоров в базу назначения завершен.")
    end
  end

end

