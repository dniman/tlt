namespace :objects do
  namespace :engineering_network do
    namespace :destination do
      namespace :mss_detail_list do

        task :insert do |t|
          def link_type_query(code)
            Destination.mss_objects_types 
            .project(Destination.mss_objects_types[:link])
            .where(Destination.mss_objects_types[:code].eq(code))
          end
          
          def query
            link_type = Destination.execute_query(link_type_query('ENGINEERING_NETWORK').to_sql).entries.first["link"]

            object_ids = Source.___ids.alias("object_ids")
            doc_form =
              Arel::Nodes::Case.new
              .when(Source.docroles[:name].eq('Основной документ')).then(1)
              .else(0)

            manager1 = Arel::SelectManager.new Database.destination_engine
            manager1.project(
              object_ids[:___link_list].as("link_list"),
              Source.___ids[:link].as("link_doc"),
              doc_form.as("doc_form"),
              Source.___ids[:row_id],
            )
            manager1.from(Source.docset_members)
            manager1.join(Source.documents).on(Source.documents[:id].eq(Source.docset_members[:document_id]))
            manager1.join(Source.objects).on(Source.objects[:docset_id].eq(Source.docset_members[:docset_id]))
            manager1.join(object_ids).on(
              object_ids[:id].eq(Source.objects[:id])
              .and(object_ids[:table_id].eq(Source::Objects.table_id))
            )
            manager1.join(Source.___ids).on(
              Source.___ids[:id].eq(Source.documents[:id])
              .and(Source.___ids[:table_id].eq(Source::Documents.table_id))
            )
            manager1.join(Source.docroles, Arel::Nodes::OuterJoin).on(Source.docroles[:id].eq(Source.docset_members[:docrole_id]))
            manager1.where(
              object_ids[:table_id].eq(Source::Objects.table_id)
              .and(object_ids[:link_type].eq(link_type))
            )
            
            manager2 = Arel::SelectManager.new Database.destination_engine
            manager2.project(
              object_ids[:___link_list].as("link_list"),
              Source.___ids[:link].as("link_doc"),
              doc_form.as("doc_form"),
              Source.___ids[:row_id],
            )
            manager2.from(Source.states)
            manager2.join(Source.objects).on(Source.objects[:id].eq(Source.states[:objects_id]))
            manager2.join(object_ids).on(
              object_ids[:id].eq(Source.objects[:id])
              .and(object_ids[:table_id].eq(Source::Objects.table_id))
            )
            manager2.join(Source.docset_members).on(Source.docset_members[:docset_id].eq(Source.states[:documents_id]))
            manager2.join(Source.documents).on(Source.documents[:id].eq(Source.docset_members[:document_id]))
            manager2.join(Source.___ids).on(
              Source.___ids[:id].eq(Source.documents[:id])
              .and(Source.___ids[:table_id].eq(Source::Documents.table_id))
            )
            manager2.join(Source.docroles, Arel::Nodes::OuterJoin).on(Source.docroles[:id].eq(Source.docset_members[:docrole_id]))
            manager2.where(
              object_ids[:table_id].eq(Source::Objects.table_id)
              .and(object_ids[:link_type].eq(link_type))
            )
            
            union = manager1.union :all, manager2
            union_table = Arel::Table.new :union_table

            manager = Arel::SelectManager.new
            manager.project(Arel.star)
            manager.distinct
            manager.from(union_table.create_table_alias(union,:union_table))
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
              subquery.from(Destination.mss_detail_list)
              subquery.where(
                Destination.mss_detail_list[:link_list].eq(values_table[:link_list])
                .and(Destination.mss_detail_list[:link_doc].eq(values_table[:link_doc]))
                .and(Destination.mss_detail_list[:doc_form].eq(values_table[:doc_form]))
              )
              
              select_manager = Arel::SelectManager.new
              select_manager.project(Arel.star)
              select_manager.from(unions.as("values_table"))
              select_manager.where(subquery.exists.not)
              
              insert_manager = Arel::InsertManager.new(Database.destination_engine).tap do |manager|
                rows.first.keys.each do |column|
                  manager.columns << Destination.mss_detail_list[column.to_sym]
                end
                manager.into(Destination.mss_detail_list)
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
