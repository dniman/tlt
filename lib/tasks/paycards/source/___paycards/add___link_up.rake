namespace :paycards do
  namespace :source do
    namespace :___paycards do

      task :add___link_up do |t|
        begin
          sql = Arel.sql(
            "alter table #{ Source.___paycards.name }
              add ___link_up int
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
