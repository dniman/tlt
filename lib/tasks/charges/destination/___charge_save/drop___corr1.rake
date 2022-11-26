namespace :charges do
  namespace :destination do
    namespace :___charge_save do
      
      task :drop___corr1 do |t|
        begin
          sql = Arel.sql(
            "if (col_length('#{ Destination.___charge_save.name }','___corr1') is not null)
            alter table #{ Destination.___charge_save.name }
              drop column ___corr1
            "
          )
          Destination.execute_query(sql).do

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
