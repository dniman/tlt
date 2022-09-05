require './lib/database'

namespace :source do
  task :establish_connection do
    begin
      Database.establish_connection(:source, Database.config)
      Rake.info "Соединение с источником '#{ Database.config['source']['database'] }' успешно установлено." if Database.source
    rescue StandardError => e
      Rake.error "Ошибка при установке соединения с источником '#{ Database.config['source']['database'] }' - #{e}."
      exit
    end
  end
end
