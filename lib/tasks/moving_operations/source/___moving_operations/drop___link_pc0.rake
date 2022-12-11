namespace :moving_operations do
  namespace :source do
    namespace :___moving_operations do
      
      task :drop___link_pc0 do |t|
        begin
          sql = Arel.sql(
            "if (col_length('#{ Source.___moving_operations.name }','___link_pc0') is not null)
            alter table #{ Source.___moving_operations.name }
              drop column ___link_pc0
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
