namespace :objects do
  namespace :land do
    namespace :destination do
      namespace :mss_objects do

        task :drop___grounds_funk_using_grounds_funk_using_id do |t|
          begin
            sql = Arel.sql(
              "if (col_length('#{ Destination.mss_objects.name }','___grounds_funk_using_grounds_funk_using_id') is not null)
              alter table #{ Destination.mss_objects.name }
                drop column ___grounds_funk_using_grounds_funk_using_id
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
