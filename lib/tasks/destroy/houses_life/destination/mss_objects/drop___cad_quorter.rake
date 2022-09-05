namespace :destroy do
  namespace :houses_life do
    namespace :destination do
      namespace :mss_objects do
        task :drop___cad_quorter do |t|
          begin
            sql = Arel.sql(
              "if (col_length('#{ Destination.mss_objects.name }','___cad_quorter') is not null)
              alter table #{ Destination.mss_objects.name }
                drop column ___cad_quorter
              "
            )
            Destination.execute_query(sql).do
            Rake.info "Задача '#{ t }' успешно выполнена."
          rescue StandardError => e
            Rake.error "Ошибка при выполнении задачи '#{ t }' - #{e}."
            exit
          end
        end
      end
    end
  end
end
