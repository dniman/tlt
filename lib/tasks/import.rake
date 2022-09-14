require 'logger'

import 'lib/tasks/import/dictionaries.rake'
import 'lib/tasks/import/objects.rake'

namespace :import do
  task :set_logger do
    Rake.logger = Logger.new Rake::MultiIO.new(STDOUT, File.open(File.join('tmp', 'import.log'), 'w'))
  end

  desc 'Запуск задачи импорта данных в базу назначения'
  task :start => [
    'set_logger', 
    'source:initialize', 
    'destination:initialize',

    'import:dictionaries:tasks',
    'import:objects:tasks',
  ] 
  
  namespace :dictionaries do
    desc 'Запуск задачи импорта справочников в базу назначения'
    task :start => [
      'set_logger', 
      'source:initialize', 
      'destination:initialize',

      'import:dictionaries:tasks',
    ] 
  end
 
  namespace :objects do
    desc 'Запуск задачи импорта объектов в базу назначения'
    task :start => [
      'set_logger', 
      'source:initialize', 
      'destination:initialize',

      'import:objects:tasks',
    ] 
  end
end

