namespace :objects do
  namespace :life_room do
    namespace :destination do
      namespace :mss_objects do

        task :update_link_cad_quorter do |t|
          begin
            update = [ 
              link_cad_quorter: Arel.sql(
                "(
                  select link 
                  from mss_objects_dicts 
                  where code = mss_objects.___cad_quorter
                    and mss_objects_dicts.object = #{ Destination::MssObjectsDicts::DICTIONARY_LAND_KVARTALS }
                    and mss_objects.link_mo = #{ Destination.link_mo }
                )"
              )
            ]
            where = Arel.sql("mss_objects.___cad_quorter is not null")
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
