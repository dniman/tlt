namespace :moving_operations do
  namespace :source do
    namespace :___moving_operations do
    
      task :create_table do
        sql = <<~SQL
          create table ___moving_operations(
            id int identity(1,1) 
            ,movetype_name varchar(30)
            ,sincedate datetime
            ,enddate datetime
            ,moveperiod_id int
            ,prev_moveperiod_id int
            ,parent_moveperiod_id int
            ,moveset_id int
            ,client_id int
            ,moveitem_id int
            ,docset_id int
            ,___agreement_id int
            ,___paycard_id int
            ,transferbasis_name varchar(50)
          )
        SQL
        
        unless Source.table_exists?('___moving_operations')
          begin  
            Source.execute_query(sql).do

            Rake.info "Таблица '___moving_operations' в базе данных '#{ Database.config['source']['database'] }' успешно создана."
          rescue StandardError => e
            Rake.error "Ошибка при создании таблицы '___moving_operations' в базе данных '#{ Database.config['source']['database'] }' - #{e}."
          end
        else
          Rake.info "Таблица '___moving_operations' в базе данных '#{ Database.config['source']['database'] }' уже существует."
        end
      end

    end 
  end
end
