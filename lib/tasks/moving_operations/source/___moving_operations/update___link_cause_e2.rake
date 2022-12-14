namespace :moving_operations do
  namespace :source do
    namespace :___moving_operations do

      task :update___link_cause_e2 do |t|

        def link_cause_e_query
          Destination.mss_decommission_causes
          .project(Destination.mss_decommission_causes[:link])
          .where(Destination.mss_decommission_causes[:name].eq('Списание')) 
        end

        def query
          link = Destination.execute_query(link_cause_e_query.to_sql).entries.first["link"]

          manager = Arel::UpdateManager.new Database.source_engine
          manager.table(Source.___moving_operations)
          manager.where(Source.___moving_operations[:movetype_name].eq('Списание'))
          manager.set([[Source.___moving_operations[:___link_cause_e], link]])              
          manager.to_sql
        end

        begin
          Source.execute_query(query).do
          
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
