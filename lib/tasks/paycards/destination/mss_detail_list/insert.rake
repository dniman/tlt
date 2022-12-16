namespace :paycards do
  namespace :destination do
    namespace :mss_detail_list do
      task :insert do |t|
        def query
          paycards_ids = Source.___ids.alias("paycards_ids")
          paycards_ids2 = Source.___ids.alias("paycards_ids2")

          doc_form =
            Arel::Nodes::NamedFunction.new('max', [
              Arel::Nodes::Case.new
              .when(Source.docroles[:name].eq('Основной документ')).then(1)
              .else(0)
            ])

          manager1 = Arel::SelectManager.new Database.destination_engine
          manager1.from(Source.docset_members)
          manager1.join(Source.documents).on(Source.documents[:id].eq(Source.docset_members[:document_id]))
          manager1.join(Source.moveperiods).on(Source.moveperiods[:docset_id].eq(Source.docset_members[:docset_id]))
          manager1.join(Source.movesets).on(Source.movesets[:id].eq(Source.moveperiods[:moveset_id]))
          manager1.join(Source.___paycards).on(
            Source.___paycards[:moveperiod_id].eq(Source.moveperiods[:id])
            .and(Source.___paycards[:moveset_id].eq(Source.movesets[:id]))
          )
          manager1.join(paycards_ids).on(
            paycards_ids[:id].eq(Source.___paycards[:id])
            .and(paycards_ids[:table_id].eq(Source::Paycards.table_id))
          )
          manager1.join(Source.___ids).on(
            Source.___ids[:id].eq(Source.documents[:id])
            .and(Source.___ids[:table_id].eq(Source::Documents.table_id))
          )
          manager1.join(Source.docroles, Arel::Nodes::OuterJoin).on(Source.docroles[:id].eq(Source.docset_members[:docrole_id]))

          manager2 = manager1.clone
          
          manager1.project(
            paycards_ids[:___link_list].as("link_list"),
            Source.___ids[:link].as("link_doc"),
            doc_form.as("doc_form"),
          )
          manager1.where(Source.___paycards[:___link_up].eq(nil))
          manager1.group(paycards_ids[:___link_list], Source.___ids[:link])

          manager2.project(
            paycards_ids2[:___link_list].as("link_list"),
            Source.___ids[:link].as("link_doc"),
            doc_form.as("doc_form"),
          )
          manager2.join(paycards_ids2).on(paycards_ids2[:link].eq(Source.___paycards[:___link_up]))
          manager2.where(Source.___paycards[:___link_up].not_eq(nil))
          manager2.group(paycards_ids2[:___link_list], Source.___ids[:link])
          
          union = manager1.union :all, manager2
          union_table = Arel::Table.new :union_table
         
          select_manager = Arel::SelectManager.new
          select_manager.project(Arel.star)
          select_manager.distinct
          select_manager.from(union_table.create_table_alias(union,:union_table))
          select_manager.where(union_table[:link_list].not_eq(nil))
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
                      Arel::Nodes::Quoted.new(row[column])
                    else
                      Arel::Nodes::Quoted.new(row[column].strftime("%Y%m%d"))
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
            )
            
            select_manager = Arel::SelectManager.new
            select_manager.project(Arel.star)
            select_manager.from(unions.as("values_table(#{ rows.first.keys.join(',') })"))
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
