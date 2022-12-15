namespace :moving_operation_objects do
  namespace :source do
    namespace :___moving_operation_objects do
      
      task :drop___link_rp do |t|
        begin
          sql = Arel.sql(
            "if (col_length('#{ Source.___moving_operation_objects.name }','___link_rp') is not null)
            alter table #{ Source.___moving_operation_objects.name }
              drop column ___link_rp
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
