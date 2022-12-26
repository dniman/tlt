namespace :corrs do
  namespace :ul do
    namespace :source do
      namespace :___ids do
        
        task :drop___main_otr_name do |t|
          begin
            sql = Arel.sql(
              "if (col_length('#{ Source.___ids.name }','___main_otr_name') is not null)
              alter table #{ Source.___ids.name }
                drop column ___main_otr_name
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
