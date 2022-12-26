namespace :dictionaries do
  namespace :kat_pol do
    namespace :source do
      namespace :___kat_pols do
      
        task :create_table do
          sql = <<~SQL
            create table ___kat_pols(
              id int identity(1,1),
              name varchar(300)
            )
          SQL
            
          unless Source.table_exists?('___kat_pols')
            begin  
              Source.execute_query(sql).do

              Rake.info "Таблица '___kat_pols' в базе данных '#{ Database.config['source']['database'] }' успешно создана."
            rescue StandardError => e
              Rake.error "Ошибка при создании таблицы '___kat_pols' в базе данных '#{ Database.config['source']['database'] }' - #{e}."

              exit
            end
          else
            Rake.info "Таблица '___kat_pols' в базе данных '#{ Database.config['source']['database'] }' уже существует."
          end
        end

      end 
    end
  end
end

