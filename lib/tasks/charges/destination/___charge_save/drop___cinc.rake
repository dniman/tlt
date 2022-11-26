namespace :charges do
  namespace :destination do
    namespace :___charge_save do
      
      task :drop___cinc do |t|
        begin
          sql = Arel.sql(
            "if (col_length('#{ Destination.___charge_save.name }','___cinc') is not null)
            alter table #{ Destination.___charge_save.name }
              drop column ___cinc
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
