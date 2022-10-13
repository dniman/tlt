namespace :objects do
  namespace :construction do
    namespace :source do
      namespace :states do

        task :drop___link_state do |t|
          begin
            sql = Arel.sql(
              "if (col_length('#{ Source.states.name }','___link_state') is not null)
              alter table #{ Source.states.name }
                drop column ___link_state
              "
            )
            Source.execute_query(sql).do
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
end
