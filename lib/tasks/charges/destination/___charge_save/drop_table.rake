namespace :charges do
  namespace :destination do
    namespace :___charge_save do
    
      task :drop_table do
        sql = <<~SQL
          drop table ___charge_save
        SQL
          
        if Destination.table_exists?('___charge_save')
          begin  
            Destination.execute_query(sql).do

            Rake.info "Таблица '___charge_save' в базе данных '#{ Database.config['destination']['database'] }' успешно удалена."
          rescue StandardError => e
            Rake.error "Ошибка при удалении таблицы '___charge_save' в базе данных '#{ Database.config['destination']['database'] }' - #{e}."
          end
        else
          Rake.info "Таблица '___charge_save' в базе данных '#{ Database.config['destination']['database'] }' не найдена."
        end
      end

    end 
  end
end

