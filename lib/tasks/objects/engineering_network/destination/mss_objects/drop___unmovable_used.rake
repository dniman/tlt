namespace :objects do
  namespace :engineering_network do
    namespace :destination do
      namespace :mss_objects do

        task :drop___unmovable_used do |t|
          begin
            sql = Arel.sql(
              "if (col_length('#{ Destination.mss_objects.name }','___unmovable_used') is not null)
              alter table #{ Destination.mss_objects.name }
                drop column ___unmovable_used
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
