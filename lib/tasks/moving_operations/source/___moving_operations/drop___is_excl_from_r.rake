namespace :moving_operations do
  namespace :source do
    namespace :___moving_operations do
      
      task :drop___is_excl_from_r do |t|
        begin
          sql = Arel.sql(
            "if (col_length('#{ Source.___ids.name }','___is_excl_from_r') is not null)
            alter table #{ Source.___moving_operations.name }
              drop column ___is_excl_from_r
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
