namespace :objects do
  namespace :unlife_room do
    namespace:source do
      namespace :ids do

        task :add___link_adr do |t|
          begin
            sql = Arel.sql(
              "alter table #{ Source.ids.name }
                add ___link_adr int
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
