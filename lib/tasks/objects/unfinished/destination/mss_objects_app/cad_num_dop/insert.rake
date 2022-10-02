namespace :objects do
  namespace :unfinished do
    namespace :destination do
      namespace :mss_objects_app do
        namespace :cad_num_dop do

          task :insert do |t|
            def link_type_query
              Destination.set_engine!
              query = 
                Destination.mss_objects_types 
                .project(Destination.mss_objects_types[:link])
                .where(Destination.mss_objects_types[:code].eq("UNFINISHED"))
            end
            
            def link_param_query(code)
              Destination.set_engine!
              query = 
                Destination.mss_objects_params
                .project(Destination.mss_objects_params[:link])
                .where(Destination.mss_objects_params[:code].eq(code))
            end

            def query
              link_type = Destination.execute_query(link_type_query.to_sql).entries.first["link"]

              Source.set_engine!
              select_one = 
                Source.objects
                .project([
                  Arel.sql("null as usl_kadastrno"),
                  Source.ids[:link],
                  Source.ids[:link_type],
                ])
                .join(Source.objtypes, Arel::Nodes::OuterJoin).on(Source.objtypes[:id].eq(Source.objects[:objtypes_id]))
                .join(Source.ids).on(Source.ids[:id].eq(Source.objects[:id]).and(Source.ids[:table_id].eq(Source::Objects.table_id)))
                .join(Source.unconstr).on(Source.unconstr[:objects_id].eq(Source.objects[:id]))
                .where(Source.ids[:link_type].eq(link_type))
              
              select_two = 
                Source.objects
                .project([
                  Source.enginf[:usl_kadastrno],
                  Source.ids[:link],
                  Source.ids[:link_type],
                ])
                .join(Source.objtypes, Arel::Nodes::OuterJoin).on(Source.objtypes[:id].eq(Source.objects[:objtypes_id]))
                .join(Source.ids).on(Source.ids[:id].eq(Source.objects[:id]).and(Source.ids[:table_id].eq(Source::Objects.table_id)))
                .join(Source.enginf).on(Source.enginf[:objects_id].eq(Source.objects[:id]))
                .join(Source.enginftypes, Arel::Nodes::OuterJoin).on(Source.enginftypes[:id].eq(Source.enginf[:enginftypes_id]))
                .where(Source.ids[:link_type].eq(link_type))
                
              union = select_one.union :all, select_two
              union_table = Arel::Table.new :union_table

              manager = Arel::SelectManager.new
              manager.project(Arel.star)
              manager.from(union_table.create_table_alias(union,:union_table))
              manager.where(union_table[:usl_kadastrno].not_eq(nil))
            end

            begin
              sql = ""
              insert = []
              link_param = Destination.execute_query(link_param_query('CAD_NUM_DOP').to_sql).entries.first["link"]
              
              sliced_rows = Source.execute_query(query.to_sql).each_slice(1000).to_a
              sliced_rows.each do |rows|
                rows.each do |row|
                  insert << {
                    link_up: row["link"],
                    link_param: link_param,
                    varchar: row["usl_kadastrno"]
                  }
                end

                condition =<<~SQL 
                  mss_objects_app.link_up = values_table.link_up 
                    and mss_objects_app.link_param = values_table.link_param
                SQL

                sql = Destination::MssObjectsApp.insert_query(rows: insert, condition: condition)
                result = Destination.execute_query(sql)
                result.do
                insert.clear
                sql.clear
              end
              
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
end
