namespace :paycards do
  namespace :source do
    namespace :___paycards do
    
      task :create_table do
        sql = <<~SQL
          create table ___paycards(
            id int identity(1,1) 
            ,___agreement_id int
            ,___order int
            ,number varchar(100)
            ,sincedate datetime
            ,enddate datetime
            ,moveperiod_id int
            ,prev_moveperiod_id int
            ,parent_moveperiod_id int
            ,moveset_id int
            ,obligation_id int
            ,obligationtype_id int
            ,obligationtype_name varchar(50)
            ,paydoc_id int
            ,client_id1 int
            ,client_id2 int
            ,summa2 numeric(20,2)
            ,cinc_a varchar(50)
            ,cinc_p varchar(50)
            ,cinc_pr varchar(50)
            ,nach_p int
            ,real_nach_p int
            ,peny_t int
            ,peny_distribution int
            ,peny_f numeric(20,6)
            ,su_t int
            ,su_m int
            ,su_d int
            ,de_t int
            ,de_m int
            ,de_d int
            ,date_f datetime
            ,amount_period int
            ,credit_rev_sum numeric(20,2)
            ,date_f_pay datetime
            ,summa_f numeric(20,2)
            ,prc decimal(4,2)
            ,credit_year_days int
            ,is_multi_subject varchar(1)
            ,in_contract varchar(1)
            ,in_progress varchar(1)
          )
        SQL
        
        unless Source.table_exists?('___paycards')
          begin  
            Source.execute_query(sql).do

            Rake.info "Таблица '___paycards' в базе данных '#{ Database.config['source']['database'] }' успешно создана."
          rescue StandardError => e
            Rake.error "Ошибка при создании таблицы '___paycards' в базе данных '#{ Database.config['source']['database'] }' - #{e}."
          end
        else
          Rake.info "Таблица '___paycards' в базе данных '#{ Database.config['source']['database'] }' уже существует."
        end
      end

    end 
  end
end
