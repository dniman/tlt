namespace :import do
  namespace :land do
    namespace :destination do
      namespace :mss_adr do
        task :update do |t|
          begin
          Destination.set_engine!
          subquery = 
            Destination.mss_objects
            .project(Destination.mss_objects[:link_adr])
            .distinct
            .join(Destination.mss_objects_types, Arel::Nodes::OuterJoin)
              .on(Destination.mss_objects_types[:link].eq(Destination.mss_objects[:link_type]))
            .where(Destination.mss_objects_types[:code].eq('LAND'))

            update = [ 
              adr: Arel.sql("(select isnull(adr,'') from mss_objects_adr where link_up = mss_adr.link)"),
              adr_full: Arel.sql("(select '\"' + isnull(adr,'') + '\"' from mss_objects_adr where link_up = mss_adr.link)")
            ]
            where = Arel.sql("mss_adr.link in (#{ subquery.to_sql })")
            sql = Destination::MssAdr.update_query(row: update, where: where)
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
