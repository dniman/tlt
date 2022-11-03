namespace :objects do
  namespace :engineering_network do
    namespace :destination do
      namespace :mss_objects do

        task :drop___vid_obj_zkx do |t|
          begin
            sql = Arel.sql(
              "if (col_length('#{ Destination.mss_objects.name }','___vid_obj_zkx') is not null)
              alter table #{ Destination.mss_objects.name }
                drop column ___vid_obj_zkx
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
