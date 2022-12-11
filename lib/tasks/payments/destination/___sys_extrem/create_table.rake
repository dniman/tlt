namespace :payments do
  namespace :destination do
    namespace :___sys_extrem do
    
      task :create_table do
        sql = <<~SQL
          create table ___sys_extrem(
            upd int,
            del int,
            marker int,
            checked int,
            object int,
            pc int,
            link int,
            linkre int,
            rem1 int,
            rem3 int,
            number varchar(10),
            number_el varchar(36),
            date datetime,
            date_exec datetime,
            summa money,
            summa_a money,
            summa_p money,
            cppu1 varchar(9),
            bic1 varchar(9),
            bank_n1 varchar(100),
            ks1 varchar(20),
            cppu2 varchar(9),
            bic2 varchar(9),
            bank_n2 varchar(100),
            ks2 varchar(20),
            paystatus varchar(2),
            paycate varchar(11),
            payreason varchar(2),
            payperiod varchar(10),
            payincnumb varchar(15),
            payincdate varchar(10),
            payinctype varchar(2),
            paycincome varchar(20),
            note1 varchar(210),
            ccorr1 varchar(13),
            corr_n1 varchar(160),
            caccount1 varchar(20),
            ccorr2 varchar(13),
            corr_n2 varchar(160),
            caccount2 varchar(20),
            pay_stack int,
            pay_date datetime,
            cuid varchar(36),
            payuin varchar(25),
            baccount int,
            cbaccount varchar(20),
            cbacc_corr varchar(45),
            income int,
            cincome varchar(20),
            income_n varchar(60),
            ate int,
            cate varchar(11),
            ate_sname varchar(45),
            imns int,
            cimns varchar(13),
            imns_sname varchar(45),
            priznak varchar(80),
            oper int,
            soper varchar(20),
            coper varchar(90),
            row_pp uniqueidentifier,
            type int
          )
        SQL
          
        unless Destination.table_exists?('___sys_extrem')
          begin  
            Destination.execute_query(sql).do

            Rake.info "Таблица '___sys_extrem' в базе данных '#{ Database.config['destination']['database'] }' успешно создана."
          rescue StandardError => e
            Rake.error "Ошибка при создании таблицы '___sys_extrem' в базе данных '#{ Database.config['destination']['database'] }' - #{e}."
          end
        else
          Rake.info "Таблица '___sys_extrem' в базе данных '#{ Database.config['destination']['database'] }' уже существует."
        end
      end

    end 
  end
end

