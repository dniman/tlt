namespace :import do
  namespace :land do
    namespace :source do
      namespace :ids do
        task :drop___adr_str do |t|
          begin
            sql = Arel.sql(
              "if (col_length('#{ Source.ids.name }','___adr_str') is not null)
              alter table #{ Source.ids.name }
                drop column ___adr_str
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
end
