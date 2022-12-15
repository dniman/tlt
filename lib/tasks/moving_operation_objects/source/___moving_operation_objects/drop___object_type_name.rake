namespace :moving_operation_objects do
  namespace :source do
    namespace :___moving_operation_objects do
      
      task :drop___object_type_name do |t|
        begin
          sql = Arel.sql(
            "if (col_length('#{ Source.___moving_operation_objects.name }','___object_type_name') is not null)
            alter table #{ Source.___moving_operation_objects.name }
              drop column ___object_type_name
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