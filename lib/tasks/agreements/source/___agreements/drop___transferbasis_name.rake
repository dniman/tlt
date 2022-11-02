namespace :agreements do
  namespace :source do
    namespace :___agreements do
      
      task :drop___transferbasis_name do |t|
        begin
          sql = Arel.sql(
            "if (col_length('#{ Source.___agreements.name }','___transferbasis_name') is not null)
            alter table #{ Source.___agreements.name }
              drop column ___transferbasis_name
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
