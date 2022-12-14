namespace :moving_operations do
  namespace :source do
    namespace :___moving_operations do

      task :update___link_corr2 do |t|

        def query
          manager = Arel::UpdateManager.new(Database.source_engine)
          manager.set([[Source.___moving_operations[:___link_corr], Destination.link_mo]])
          manager.table(Source.___moving_operations)
          manager.where(Source.___moving_operations[:client_id].eq(5100))

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
