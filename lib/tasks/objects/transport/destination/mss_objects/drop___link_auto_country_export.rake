namespace :objects do
  namespace :transport do
    namespace :destination do
      namespace :mss_objects do

        task :drop___link_auto_country_export do |t|
          begin
            sql = Arel.sql(
              "if (col_length('#{ Destination.mss_objects.name }','___link_auto_country_export') is not null)
              alter table #{ Destination.mss_objects.name }
                drop column ___link_auto_country_export
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
