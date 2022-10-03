namespace :objects do
  namespace :exright_intellprop do
    namespace :destination do
      namespace :mss_objects do

        task :drop___dict_name do |t|
          begin
            sql = Arel.sql(
              "if (col_length('#{ Destination.mss_objects.name }','___dict_name') is not null)
              alter table #{ Destination.mss_objects.name }
                drop column ___dict_name
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
