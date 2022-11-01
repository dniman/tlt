namespace :agreements do
  namespace :source do
    namespace :___agreements do
      
      task :drop___ground_owner_count do |t|
        begin
          sql = Arel.sql(
            "if (col_length('#{ Source.___agreements.name }','___ground_owner_count') is not null)
            alter table #{ Source.___agreements.name }
              drop column ___ground_owner_count
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
