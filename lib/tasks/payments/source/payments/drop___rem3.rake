namespace :payments do
  namespace :source do
    namespace :payments do
      
      task :drop___rem3 do |t|
        begin
          sql = Arel.sql(
            "if (col_length('#{ Source.payments.name }','___rem3') is not null)
            alter table #{ Source.payments.name }
              drop column ___rem3
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
