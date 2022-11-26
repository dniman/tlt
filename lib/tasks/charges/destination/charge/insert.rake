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

            select * into #charge_save from ___charge_save  
            select * into #pd_save from pd_save_stru
            select * into #isp_save from isp_save_stru
            select * into #pd_save2 from pd_save2_stru

            declare @LinkN int
            exec dbo.ChargeSave @Link = @LinkN
          QUERY
        end
        
        begin
          res = Destination.execute_query(query)
          res.do

          Rake.info "Задача '#{ t }' успешно выполнена."
        rescue StandardError => e
          Rake.error "Ошибка при выполнении задачи '#{ t }' - #{e}."
          Rake.info "Текст запроса \"#{ sql }\""

          exit
        end
      end

    end
  end
end
