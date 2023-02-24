namespace :charges do
  namespace :destination do
    namespace :___charge_save do
    
      task :create_table do
        sql = <<~SQL
          create table ___charge_save(
            upd int,
            link int,
            link1 int,
            link_up int,
            r1 int,
            r2 int,
            r3 int,
            c int,
            entry int,
            name int,
            type int,
            noper int,
            ntype int,
            number varchar(50),
            rdate datetime,
            date_exec datetime,
            date_b datetime,
            date_e datetime,
            summa numeric(20, 2),
            type1 int,
            ccorr1 varchar(13),
            cppu1 varchar(9),
            corr_n1 varchar(250),
            addr1 varchar(250),
            pasp1 varchar(250),
            imns int,
            inc int,
            ate int,
            acc int,
            note varchar(250),
            el_num varchar(50),
            cuid varchar(50),
            isp varchar(100),
            status int,
            pc int,
            an_pr varchar(250),
            row_id uniqueidentifier,
            c_arch uniqueidentifier,
            do_name varchar(100),
            do_num varchar(50),
            do_date datetime,
            do_note varchar(250),
            nstatus int,
            cstatus varchar(250),
            UNOM varchar(25),
            A011 varchar(2),
            A001 varchar(12),
            A004 datetime,
            A215 varchar(2),
            A205 varchar(10),
            A113 varchar(1),
            A000 varchar(2),
            A017 varchar(10),
            A110 int,
            pcc int,
            uin varchar(25),
            eip1 varchar(22),
            eip2 varchar(25),
            snils varchar(11),
            eip2_doc varchar(2),
            eip2_num varchar(20),
            eip2_nat varchar(3),
            service int,
            imns_sono varchar(10),
            admpr_stat int,
            charge_p int,
            on_schedule int,
            rnum int,
          )
        SQL
          
        unless Destination.table_exists?('___charge_save')
          begin  
            Destination.execute_query(sql).do

            Rake.info "Таблица '___charge_save' в базе данных '#{ Database.config['destination']['database'] }' успешно создана."
          rescue StandardError => e
            Rake.error "Ошибка при создании таблицы '___charge_save' в базе данных '#{ Database.config['destination']['database'] }' - #{e}."
          end
        else
          Rake.info "Таблица '___charge_save' в базе данных '#{ Database.config['destination']['database'] }' уже существует."
        end
      end

    end 
  end
end

