namespace :dictionaries do
  namespace :kbk do
    namespace:source do
      namespace :cls_kbk do

        task :add___link_program do |t|
          begin
            sql = Arel.sql(
              "alter table #{ Source.cls_kbk.name }
                add ___link_program int
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
end
