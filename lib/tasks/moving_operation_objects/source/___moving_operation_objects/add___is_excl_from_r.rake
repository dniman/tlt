namespace :moving_operation_objects do
  namespace :source do
    namespace :___moving_operation_objects do

      task :add___is_excl_from_r do |t|
        begin
          sql = Arel.sql(
            "alter table #{ Source.___moving_operation_objects.name }
              add ___is_excl_from_r int
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
