namespace :corrs do
  namespace :ul do
    namespace :source do
      namespace :___ids do

        task :add___industry_name do |t|
          begin
            sql = Arel.sql(
              "alter table #{ Source.___ids.name }
                add ___industry_name varchar(100) 
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
