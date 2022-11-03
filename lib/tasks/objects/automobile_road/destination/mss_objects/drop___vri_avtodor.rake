namespace :objects do
  namespace :automobile_road do
    namespace :destination do
      namespace :mss_objects do

        task :drop___vri_avtodor do |t|
          begin
            sql = Arel.sql(
              "if (col_length('#{ Destination.mss_objects.name }','___vri_avtodor') is not null)
              alter table #{ Destination.mss_objects.name }
                drop column ___vri_avtodor
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
