namespace :objects do
  namespace :transport do
    namespace :source do
      namespace :___ids do
        
        task :drop___link_list do |t|
          begin
            sql = Arel.sql(
              "if (col_length('#{ Source.___ids.name }','___link_list') is not null)
              alter table #{ Source.___ids.name }
                drop column ___link_list
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
