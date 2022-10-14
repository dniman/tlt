namespace :documents do
  namespace :destination do
    namespace :mss_docs do

      task :update_link_type do |t|
        def link_base_query
          Destination.mss_objcorr_types
          .project(Destination.mss_objcorr_types[:link])
          .where(Destination.mss_objcorr_types[:code].eq('doc'))
        end

        begin
          link_base = Destination.execute_query(link_base_query.to_sql).entries.first["link"]

          update = [ 
            link_type: Arel.sql(
              "(
                select link 
                from mss_objcorr_types 
                where name = mss_docs.___type
                  and mss_objcorr_types.link_base = #{ link_base }
              )"
            )
          ]
          where = Arel.sql("mss_docs.___type is not null")
          sql = Destination::MssDocs.update_query(row: update, where: where)
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
