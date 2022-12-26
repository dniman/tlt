namespace :corrs do
  namespace :fl_pers do
    namespace :destination do
      namespace :mss_objcorr_docs do
        
        task :insert do |t|
          def query
            client_ids = Source.___ids.alias("client_ids")

            manager = Arel::SelectManager.new Database.destination_engine
            manager.project(
              client_ids[:___link].as("link_objcorr"),
              Source.___ids[:link].as("link_doc"),
            )
            manager.from(Source.docset_members)
            manager.join(Source.documents).on(Source.documents[:id].eq(Source.docset_members[:document_id]))
            manager.join(Source.clients).on(Source.clients[:regdoc_id].eq(Source.docset_members[:docset_id]))
            manager.join(Source.client_types, Arel::Nodes::OuterJoin).on(Source.client_types[:id].eq(Source.clients[:client_types_id]))
            manager.join(client_ids).on(
              client_ids[:id].eq(Source.clients[:id])
              .and(client_ids[:table_id].eq(Source::Clients.table_id))
            )
            manager.join(Source.___ids).on(
              Source.___ids[:id].eq(Source.documents[:id])
              .and(Source.___ids[:table_id].eq(Source::Documents.table_id))
            )
            manager.join(Source.docroles, Arel::Nodes::OuterJoin).on(Source.docroles[:id].eq(Source.docset_members[:docrole_id]))
            manager.where(
              Source.client_types[:name].eq('Физическое лицо')
              .and(client_ids[:link].not_eq(nil))
            )
          end

          begin
            sql = ""
            selects = []
            
            Source.execute_query(query.to_sql).each_slice(1000) do |rows|
              rows.each do |row|
                Arel::SelectManager.new.tap do |select|
                  projects = []
                  row.keys.each do |column|
                    projects <<
                      unless row[column].is_a?(Time)
                        Arel::Nodes::Quoted.new(row[column]).as(column)
                      else
                        Arel::Nodes::Quoted.new(row[column].strftime("%Y%m%d")).as(column)
                      end
                  end
                  selects << select.project(projects)
                end
              end
              
              unions = Arel::Nodes::UnionAll.new(selects[0], selects[1])
              selects[2..-1].each do |select|
                unions = Arel::Nodes::UnionAll.new(unions, select)
              end

              values_table = Arel::Table.new(:values_table)

              subquery = Arel::SelectManager.new Database.destination_engine
              subquery.project(Arel.star)
              subquery.from(Destination.mss_objcorr_docs)
              subquery.where(
                Destination.mss_objcorr_docs[:link_objcorr].eq(values_table[:link_objcorr])
                .and(Destination.mss_objcorr_docs[:link_doc].eq(values_table[:link_doc]))
              )
              
              select_manager = Arel::SelectManager.new
              select_manager.project(Arel.star)
              select_manager.from(unions.as("values_table"))
              select_manager.where(subquery.exists.not)
              
              insert_manager = Arel::InsertManager.new(Database.destination_engine).tap do |manager|
                rows.first.keys.each do |column|
                  manager.columns << Destination.mss_objcorr_docs[column.to_sym]
                end
                manager.into(Destination.mss_objcorr_docs)
                manager.select(select_manager)
              end
              sql = insert_manager.to_sql
              
              result = Destination.execute_query(sql)
              result.do
              selects.clear
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
