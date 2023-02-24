namespace :charges do
  namespace :destination do
    namespace :charge do

      task :insert do |t|

        def query 
          <<~QUERY
            if object_id('tempdb..#charge_save') is not null drop table #charge_save
            if object_id('tempdb..#pd_save') is not null drop table #pd_save
            if object_id('tempdb..#isp_save') is not null drop table #isp_save
            if object_id('tempdb..#pd_save2') is not null drop table #pd_save2

            select
              upd,
              link,
              link1,
              link_up,
              r1,
              r2,
              r3,
              c,
              entry,
              name,
              type,
              noper,
              ntype,
              number,
              rdate,
              date_exec,
              date_b,
              date_e,
              summa,
              type1,
              ccorr1,
              cppu1,
              corr_n1,
              addr1,
              pasp1,
              imns,
              inc,
              ate,
              acc,
              note,
              el_num,
              cuid,
              isp,
              status,
              pc,
              an_pr,
              row_id,
              c_arch,
              do_name,
              do_num,
              do_date,
              do_note,
              nstatus,
              cstatus,
              UNOM,
              A011,
              A001,
              A004,
              A215,
              A205,
              A113,
              A000,
              A017,
              A110,
              pcc,
              uin,
              eip1,
              eip2,
              snils,
              eip2_doc,
              eip2_num,
              eip2_nat,
              service,
              imns_sono,
              admpr_stat,
              charge_p,
              on_schedule,
            into #charge_save 
            from ___charge_save  
            where rnum = 1
            select * into #pd_save from pd_save_stru
            select * into #isp_save from isp_save_stru
            select * into #pd_save2 from pd_save2_stru

            declare @LinkN int
            exec dbo.ChargeSave @Link = @LinkN
          QUERY
        end
        
        begin
          Destination.execute_query(query).do

          Rake.info "Задача '#{ t }' успешно выполнена."
        rescue StandardError => e
          Rake.error "Ошибка при выполнении задачи '#{ t }' - #{e}."
          Rake.info "Текст запроса \"#{ query }\""

          exit
        end
      end

    end
  end
end
