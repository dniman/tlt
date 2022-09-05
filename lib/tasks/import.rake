require 'logger'

import 'lib/tasks/import/land.rake'
import 'lib/tasks/import/houses_life.rake'
import 'lib/tasks/import/houses_unlife.rake'
import 'lib/tasks/import/construction.rake'
import 'lib/tasks/import/unfinished.rake'
import 'lib/tasks/import/life_room.rake'
import 'lib/tasks/import/unlife_room.rake'

namespace :import do
  task :set_logger do
    Rake.logger = Logger.new File.open(File.join('tmp', 'import.log'), 'w')
  end

  desc 'Запуск задачи импорта данных в базу назначения'
  task :start => [
    'set_logger', 
    'source:initialize', 
    'destination:initialize',

    'import:land:tasks',
    'import:houses_life:tasks',
    'import:houses_unlife:tasks',
    'import:construction:tasks',
    'import:unfinished:tasks',
    'import:life_room:tasks',
    'import:unlife_room:tasks'
  ] 
end

