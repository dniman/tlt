namespace :dictionaries do
  namespace :main_otr do
    namespace :source do
      namespace :___main_otrs do
      
        task :create_table do
          sql = <<~SQL
            create table ___main_otrs(
              id int identity(1,1),
              name varchar(50)
            )
          SQL
            
          unless Source.table_exists?('___main_otrs')
            begin  
              Source.execute_query(sql).do

              Rake.info "Таблица '___main_otrs' в базе данных '#{ Database.config['source']['database'] }' успешно создана."
            rescue StandardError => e
              Rake.error "Ошибка при создании таблицы '___main_otrs' в базе данных '#{ Database.config['source']['database'] }' - #{e}."

              exit
            end
          else
            Rake.info "Таблица '___main_otrs' в базе данных '#{ Database.config['source']['database'] }' уже существует."
          end
        end

      end 
    end
  end
end

