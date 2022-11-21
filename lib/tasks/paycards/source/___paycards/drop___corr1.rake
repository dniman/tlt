namespace :paycards do
  namespace :source do
    namespace :___paycards do
      
      task :drop___corr1 do |t|
        begin
          sql = Arel.sql(
            "if (col_length('#{ Source.___paycards.name }','___corr1') is not null)
            alter table #{ Source.___paycards.name }
              drop column ___corr1
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
