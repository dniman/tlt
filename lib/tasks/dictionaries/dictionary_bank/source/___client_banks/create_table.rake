namespace :dictionaries do
  namespace :dictionary_bank do
    namespace :source do
      namespace :___client_banks do
      
        task :create_table do
          sql = <<~SQL
            create table ___client_banks(
              id int identity(1,1),
              name varchar(100)
              ,bic varchar(9)
              ,ks varchar(20)
            )
          SQL
            
          unless Source.table_exists?('___client_banks')
            begin  
              Source.execute_query(sql).do

              Rake.info "Таблица '___client_banks' в базе данных '#{ Database.config['source']['database'] }' успешно создана."
            rescue StandardError => e
              Rake.error "Ошибка при создании таблицы '___client_banks' в базе данных '#{ Database.config['source']['database'] }' - #{e}."

              exit
            end
          else
            Rake.info "Таблица '___client_banks' в базе данных '#{ Database.config['source']['database'] }' уже существует."
          end
        end

      end 
    end
  end
end

