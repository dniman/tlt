namespace :moving_operation_objects do
  namespace :source do
    namespace :___moving_operation_objects do

      task :add___object_type_name do |t|
        begin
          sql = Arel.sql(
            "alter table #{ Source.___moving_operation_objects.name }
              add ___object_type_name varchar(255)
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
