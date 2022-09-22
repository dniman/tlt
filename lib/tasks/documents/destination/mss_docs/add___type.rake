namespace :documents do
  namespace:destination do
    namespace :mss_docs do

      task :add___type do |t|
        begin
          sql = Arel.sql(
            "alter table #{ Destination.mss_docs.name }
              add ___type varchar(255)
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
