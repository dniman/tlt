namespace :objects do
  namespace :inland_waterway_vessel do
    namespace :destination do
      namespace :mss_objects do

        task :drop___color_kuzov do |t|
          begin
            sql = Arel.sql(
              "if (col_length('#{ Destination.mss_objects.name }','___color_kuzov') is not null)
              alter table #{ Destination.mss_objects.name }
                drop column ___color_kuzov
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
