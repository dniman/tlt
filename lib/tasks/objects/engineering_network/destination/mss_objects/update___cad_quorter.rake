namespace :objects do
  namespace :engineering_network do
    namespace :destination do
      namespace :mss_objects do

        task :update___cad_quorter do |t|
          begin
            update = [ 
              ___cad_quorter: Arel.sql(
                "iif(charindex(':', mss_objects.___kadastrno, 1) > 0, reverse(substring(reverse(mss_objects.___kadastrno),charindex(':', reverse(mss_objects.___kadastrno), 1) + 1, len(mss_objects.___kadastrno) - charindex(':', reverse(mss_objects.___kadastrno), 1))), null)"
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
