namespace :objects do
  namespace :life_room do
    namespace :destination do
      namespace :mss_objects do

        task :update___link_house_wall_type do |t|
          def link_param_query(code)
            Destination.set_engine!
            query = 
              Destination.mss_objects_params
              .project(Destination.mss_objects_params[:link])
              .where(Destination.mss_objects_params[:code].eq(code))
          end

          begin
            link_param = Destination.execute_query(link_param_query('HOUSE_WALL_TYPE').to_sql).entries.first["link"]

            update = [ 
              ___link_house_wall_type: Arel.sql(
                "(
                  select link 
                  from mss_objects_dicts 
                  where name = mss_objects.___house_wall_type
                    and mss_objects_dicts.link_dict = #{ link_param }
                )"
              )
            ]
            where = Arel.sql("mss_objects.___house_wall_type is not null")
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
