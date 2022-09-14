namespace :import do
  namespace :houses_unlife do
    namespace :destination do
      namespace :mss_objects do
        task :add___kadastrno do |t|
          begin
            sql = Arel.sql(
              "alter table #{ Destination.mss_objects.name }
                add ___kadastrno varchar(300)
              "
            )
            Destination.execute_query(sql).do
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
