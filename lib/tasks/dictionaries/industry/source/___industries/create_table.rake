namespace :dictionaries do
  namespace :industry do
    namespace :source do
      namespace :___industries do
      
        task :create_table do
          sql = <<~SQL
            create table ___industries(
              id int identity(1,1),
              name varchar(100)
            )
          SQL
            
          unless Source.table_exists?('___industries')
            begin  
              Source.execute_query(sql).do

              Rake.info "Таблица '___industries' в базе данных '#{ Database.config['source']['database'] }' успешно создана."
            rescue StandardError => e
              Rake.error "Ошибка при создании таблицы '___industries' в базе данных '#{ Database.config['source']['database'] }' - #{e}."

              exit
            end
          else
            Rake.info "Таблица '___industries' в базе данных '#{ Database.config['source']['database'] }' уже существует."
          end
        end

      end 
    end
  end
end

