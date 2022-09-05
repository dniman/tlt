require './lib/database'

namespace :destination do
  task :establish_connection do
    begin
      Database.establish_connection(:destination, Database.config)
      Rake.info "Соединение с приемником '#{ Database.config['destination']['database'] }' успешно установлено." if Database.destination
    
    rescue StandardError => e
      Rake.error "Ошибка при установке соединения с приемником '#{ Database.config['destination']['database'] }' - #{e}."
      exit
    end
  end
end
