namespace :moving_operations do
  namespace :source do
    namespace :___ids do
      
      task :drop___is_change_reestr do |t|
        begin
          sql = Arel.sql(
            "if (col_length('#{ Source.___ids.name }','___is_change_reestr') is not null)
            alter table #{ Source.___is_change_reestr.name }
              drop column ___is_change_reestr
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
