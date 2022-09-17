namespace :objects do
  namespace :construction do
    namespace:source do
      namespace :ids do

        task :add___adr_str do |t|
          begin
            sql = Arel.sql(
              "alter table #{ Source.ids.name }
                add ___adr_str varchar(2000)
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