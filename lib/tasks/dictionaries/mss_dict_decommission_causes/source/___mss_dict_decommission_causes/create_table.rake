namespace :dictionaries do
  namespace :mss_dict_decommission_causes do
    namespace :source do
      namespace :___mss_dict_decommission_causes do
      
        task :create_table do
          sql = <<~SQL
            create table ___mss_dict_decommission_causes(
              id int identity(1,1),
              name varchar(50)
            )
          SQL
            
          unless Source.table_exists?('___mss_dict_decommission_causes')
            begin  
              Source.execute_query(sql).do

              Rake.info "Таблица '___mss_dict_decommission_causes' в базе данных '#{ Database.config['source']['database'] }' успешно создана."
            rescue StandardError => e
              Rake.error "Ошибка при создании таблицы '___mss_dict_decommission_causes' в базе данных '#{ Database.config['source']['database'] }' - #{e}."
            end
          else
            Rake.info "Таблица '___mss_dict_decommission_causes' в базе данных '#{ Database.config['source']['database'] }' уже существует."
          end
        end

      end 
    end
  end
end

