namespace :objects do
  namespace :unlife_room do
    namespace :source do
      namespace :states do

        task :add___link_state do |t|
          begin
            sql = Arel.sql(
              "alter table #{ Source.states.name }
                add ___link_state int
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
