namespace :import do
  namespace :unfinished do
    namespace :destination do
      namespace :mss_objects do
        task :update_inventar_num do |t|
          begin
            update = [ 
              inventar_num: Arel.sql(
                "iif(charindex(':', reverse(mss_objects.___kadastrno), 1) > 0, reverse(substring(reverse(mss_objects.___kadastrno), 1, charindex(':', reverse(mss_objects.___kadastrno), 1) - 1)), null)"
              )
            ]
            where = Arel.sql("mss_objects.___kadastrno is not null")
            sql = Destination::MssObjects.update_query(row: update, where: where)
            result = Destination.execute_query(sql)
            result.do
            
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
