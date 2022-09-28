namespace :objects do
  namespace :houses_unlife do
    namespace :destination do
      namespace :mss_objects do
        
        task :add___link_is_immovable do |t|
          begin
            sql = Arel.sql(
              "alter table #{ Destination.mss_objects.name }
                add ___link_is_immovable int
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
