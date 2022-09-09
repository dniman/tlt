require 'logger'

import 'lib/tasks/destroy/land.rake'
import 'lib/tasks/destroy/houses_life.rake'
import 'lib/tasks/destroy/houses_unlife.rake'
import 'lib/tasks/destroy/construction.rake'
import 'lib/tasks/destroy/unfinished.rake'
import 'lib/tasks/destroy/life_room.rake'
import 'lib/tasks/destroy/unlife_room.rake'

namespace :destroy do
  task :set_logger do
    Rake.logger = Logger.new Rake::MultiIO.new(STDOUT, File.open(File.join('tmp', 'destroy.log'), 'w'))
  end

  desc 'Запуск задачи удаления данных в базе назначения'
  task :start => [
    'destroy:set_logger',
    'source:initialize', 
    'destination:initialize',

    'destroy:land:tasks',
    'destroy:houses_life:tasks',
    'destroy:houses_unlife:tasks',
    'destroy:construction:tasks',
    'destroy:unfinished:tasks',
    'destroy:life_room:tasks',
    'destroy:unlife_room:tasks'
  ]
end

