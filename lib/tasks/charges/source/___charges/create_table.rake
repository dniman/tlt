namespace :charges do
  namespace :source do
    namespace :___charges do
      
      task :create_table do
        sql = <<~SQL
          create table ___charges(
            id int identity(1,1),
            charges_id numeric(27,0),
            payments_plan_id numeric(27,0) 
          )
        SQL
          
        unless Source.table_exists?('___charges')
          begin  
            Source.execute_query(sql).do

            Rake.info "Таблица '___charges' в базе данных '#{ Database.config['source']['database'] }' успешно создана."
          rescue StandardError => e
            Rake.error "Ошибка при создании таблицы '___charges' в базе данных '#{ Database.config['source']['database'] }' - #{e}."
          end
        else
          Rake.info "Таблица '___charges' в базе данных '#{ Database.config['source']['database'] }' уже существует."
        end
      end

    end 
  end
end

