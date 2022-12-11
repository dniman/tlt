namespace :dictionaries do
  namespace :mss_movescausesb_di do
    namespace :source do
      namespace :___mss_movescausesb_di do
      
        task :create_table do
          sql = <<~SQL
            create table ___mss_movescausesb_di(
              id int identity(1,1),
              name varchar(50)
            )
          SQL
            
          unless Source.table_exists?('___mss_movescausesb_di')
            begin  
              Source.execute_query(sql).do

              Rake.info "Таблица '___mss_movescausesb_di' в базе данных '#{ Database.config['source']['database'] }' успешно создана."
            rescue StandardError => e
              Rake.error "Ошибка при создании таблицы '___mss_movescausesb_di' в базе данных '#{ Database.config['source']['database'] }' - #{e}."
            end
          else
            Rake.info "Таблица '___mss_movescausesb_di' в базе данных '#{ Database.config['source']['database'] }' уже существует."
          end
        end

      end 
    end
  end
end

