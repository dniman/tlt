namespace :agreements do
  namespace :source do
    namespace :___agreements do
    
      task :create_table do
        sql = <<~SQL
          create table ___agreements(
            id int identity(1,1) 
            ,movetype_name varchar(30)
            ,document_id int
            ,number varchar(100)
            ,name varchar(150)
          )
        SQL
        
        unless Source.table_exists?('___agreements')
          begin  
            Source.execute_query(sql).do

            Rake.info "Таблица '___agreements' в базе данных '#{ Database.config['source']['database'] }' успешно создана."
          rescue StandardError => e
            Rake.error "Ошибка при создании таблицы '___agreements' в базе данных '#{ Database.config['source']['database'] }' - #{e}."
          end
        else
          Rake.info "Таблица '___agreements' в базе данных '#{ Database.config['source']['database'] }' уже существует."
        end
      end

    end 
  end
end
