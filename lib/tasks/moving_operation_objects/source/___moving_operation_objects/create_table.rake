namespace :moving_operation_objects do
  namespace :source do
    namespace :___moving_operation_objects do
    
      task :create_table do
        sql = <<~SQL
          create table ___moving_operation_objects(
            id int identity(1,1) 
            ,___moving_operation_id int
            ,object_id int
            ,objectusing_id int
            ,___paycardobject_id int
            ,func_using_id int
            ,summa2 numeric(20,2)
            ,part_num int
            ,part_name varchar(1000)
            ,area1 numeric(20,2)
            ,share_size numeric(20,2)
            ,numerator int
            ,denominator int
          )
        SQL
        
        unless Source.table_exists?('___moving_operation_objects')
          begin  
            Source.execute_query(sql).do

            Rake.info "Таблица '___moving_operation_objects' в базе данных '#{ Database.config['source']['database'] }' успешно создана."
          rescue StandardError => e
            Rake.error "Ошибка при создании таблицы '___moving_operation_objects' в базе данных '#{ Database.config['source']['database'] }' - #{e}."
          end
        else
          Rake.info "Таблица '___moving_operation_objects' в базе данных '#{ Database.config['source']['database'] }' уже существует."
        end
      end

    end 
  end
end
