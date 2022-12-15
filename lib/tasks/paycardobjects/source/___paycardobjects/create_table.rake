namespace :paycardobjects do
  namespace :source do
    namespace :___paycardobjects do
    
      task :create_table do
        sql = <<~SQL
          create table ___paycardobjects(
            id int identity(1,1) 
            ,___paycard_id int
            ,moveitem_id int
            ,object_id int
            ,objectusing_id int
            ,func_using_id int
            ,part_num int
            ,part_name varchar(1000)
            ,area1 numeric(20,2)
            ,share_size numeric(20,2)
            ,numerator int
            ,denominator int
          )
        SQL
        
        unless Source.table_exists?('___paycardobjects')
          begin  
            Source.execute_query(sql).do

            Rake.info "Таблица '___paycardobjects' в базе данных '#{ Database.config['source']['database'] }' успешно создана."
          rescue StandardError => e
            Rake.error "Ошибка при создании таблицы '___paycardobjects' в базе данных '#{ Database.config['source']['database'] }' - #{e}."
          end
        else
          Rake.info "Таблица '___paycardobjects' в базе данных '#{ Database.config['source']['database'] }' уже существует."
        end
      end

    end 
  end
end
