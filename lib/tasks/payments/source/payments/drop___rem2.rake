namespace :payments do
  namespace :source do
    namespace :payments do
      
      task :drop___rem2 do |t|
        begin
          sql = Arel.sql(
            "if (col_length('#{ Source.payments.name }','___rem2') is not null)
            alter table #{ Source.payments.name }
              drop column ___rem2
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
