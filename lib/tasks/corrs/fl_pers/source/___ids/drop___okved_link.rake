namespace :corrs do
  namespace :fl_pers do
    namespace :source do
      namespace :___ids do
        
        task :drop___okved_link do |t|
          begin
            sql = Arel.sql(
              "if (col_length('#{ Source.___ids.name }','___okved_link') is not null)
              alter table #{ Source.___ids.name }
                drop column ___okved_link
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
