namespace :objects do
  namespace :movable_other do
    namespace :source do
      namespace :ids do

        task :drop___last_loc_addr do |t|
          begin
            sql = Arel.sql(
              "if (col_length('#{ Source.ids.name }','___last_loc_addr') is not null)
              alter table #{ Source.ids.name }
                drop column ___last_loc_addr
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
