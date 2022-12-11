namespace :moving_operations do
  namespace :source do
    namespace :___moving_operations do

      task :add___link_cause_e do |t|
        begin
          sql = Arel.sql(
            "alter table #{ Source.___moving_operations.name }
              add ___link_cause_e int
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
