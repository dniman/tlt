namespace :import do
  namespace :land do
    namespace :destination do
      namespace :mss_objects do
        task :update_link_oktmo do |t|
          begin
            update = [ 
              link_oktmo: Arel.sql("(select oktmo from mss_mo where coktmo = mss_objects.___oktmo)")
            ]
            where = Arel.sql("mss_objects.___oktmo is not null")
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
