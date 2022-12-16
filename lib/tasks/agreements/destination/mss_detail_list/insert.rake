namespace :agreements do
  namespace :destination do
    namespace :mss_detail_list do
      task :insert do |t|
        def query
          agreements_ids = Source.___ids.alias("agreements_ids")
          docroles_ids = Source.___ids.alias("docroles_ids")

          doc_form =
            Arel::Node::NamedFunction.new('max', [
              Arel::Nodes::Case.new
              .when(Source.docroles[:name].eq('Основной документ')).then(1)
              .else(0)
            ])

          manager = Arel::SelectManager.new Database.destination_engine
          manager.project(
            agreements_ids[:___link_list].as("link_list"),
            Source.___ids[:link].as("link_doc"),
            doc_form.as("doc_form"),
          )
          manager.distinct
          manager.from(Source.docset_members)
          manager.join(Source.documents).on(Source.documents[:id].eq(Source.docset_members[:document_id]))
          manager.join(Source.moveperiods).on(Source.moveperiods[:docset_id].eq(Source.docset_members[:docset_id]))
          manager.join(Source.movesets).on(Source.movesets[:id].eq(Source.moveperiods[:moveset_id]))
          manager.join(agreements_ids).on(
            agreements_ids[:id].eq(Source.movesets[:___agreement_id])
            .and(agreements_ids[:table_id].eq(Source::Agreements.table_id))
          )
          manager.join(Source.___ids).on(
            Source.___ids[:id].eq(Source.documents[:id])
            .and(Source.___ids[:table_id].eq(Source::Documents.table_id))
          )
          manager.join(Source.docroles, Arel::Nodes::OuterJoin).on(Source.docroles[:id].eq(Source.docset_members[:docrole_id]))
          manager.where(agreements_ids[:___link_list].not_eq(nil))
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
