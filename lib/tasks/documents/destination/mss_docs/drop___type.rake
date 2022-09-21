namespace :documents do
  namespace :destination do
    namespace :mss_docs do

      task :drop___type do |t|
        begin
          sql = Arel.sql(
            "if (col_length('#{ Destination.mss_objects.name }','___type') is not null)
            alter table #{ Destination.mss_objects.name }
              drop column ___type
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
