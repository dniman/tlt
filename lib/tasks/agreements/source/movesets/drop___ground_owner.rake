namespace :agreements do
  namespace :source do
    namespace :movesets do
      
      task :drop___ground_owner do |t|
        begin
          sql = Arel.sql(
            "if (col_length('#{ Source.movesets.name }','___ground_owner') is not null)
            alter table #{ Source.movesets.name }
              drop column ___ground_owner
            "
          )
          Source.execute_query(sql).do
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
