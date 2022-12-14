namespace :moving_operations do
  namespace :source do
    namespace :___moving_operations do
      
      task :drop___is_change_reestr do |t|
        begin
          sql = Arel.sql(
            "if (col_length('#{ Source.___ids.name }','___moving_operations') is not null)
            alter table #{ Source.___moving_operations.name }
              drop column ___moving_operations
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
