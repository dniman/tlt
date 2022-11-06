namespace :agreements do
  namespace :source do
    namespace :___agreements do
      
      task :drop___docstate_link do |t|
        begin
          sql = Arel.sql(
            "if (col_length('#{ Source.___agreements.name }','___docstate_link') is not null)
            alter table #{ Source.___agreements.name }
              drop column ___docstate_link
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
