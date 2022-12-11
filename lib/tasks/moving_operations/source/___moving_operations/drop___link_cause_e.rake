namespace :moving_operations do
  namespace :source do
    namespace :___moving_operations do
      
      task :drop___link_cause_e do |t|
        begin
          sql = Arel.sql(
            "if (col_length('#{ Source.___moving_operations.name }','___link_cause_e') is not null)
            alter table #{ Source.___moving_operations.name }
              drop column ___link_cause_e
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
