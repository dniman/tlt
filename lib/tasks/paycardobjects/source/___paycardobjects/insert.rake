namespace :paycardobjects do
  namespace :source do
    namespace :___paycardobjects do

      task :insert do |t|
        def query
          subquery_table = Arel::Table.new(:subquery_table)
          area1 = 
            Arel::Nodes::NamedFunction.new('convert', [ 
              Arel.sql('numeric(20,2)'), 
              Arel::Nodes::NamedFunction.new('coalesce', [Source.objectusing[:square], Source.moveitems[:square]])
            ])

          subquery = Arel::SelectManager.new Database.source_engine
          subquery.project(
            Source.___paycards[:id].as("___paycard_id"),
            Source.moveitems[:id].as("moveitem_id"),
            area1.as("area1"),
            Arel.sql('
              coalesce(
                convert(xml,objectusing.xml_param_method).value(\'(/ROOT/ORIG_VAL/PARAM[@NAME="Квв"]/@VALUE)[1]\', \'int\'),
                convert(xml,moveitems.xml_param_method).value(\'(/ROOT/ORIG_VAL/PARAM[@NAME="Квв"]/@VALUE)[1]\', \'int\')
              )').as("func_using_id"),
          )
          subquery.distinct
          subquery.from(Source.moveitems)
          subquery.join(Source.___paycards).on(Source.___paycards[:moveperiod_id].eq(Source.moveitems[:moveperiod_id]))
          subquery.join(Source.objectusing, Arel::Nodes::OuterJoin).on(Source.objectusing[:moveitem_id].eq(Source.moveitems[:id]))

          subquery_table = subquery.as("subquery_table")
          
          window = Arel::Nodes::Window.new.tap do |w|
            w.partition(Source.___paycards[:id], Source.___paycards[:moveperiod_id])
            w.order(Source.___paycards[:___order], subquery_table[:moveitem_id], Source.objectusing[:id])
          end

          part_num = Arel::Nodes::Over.new \
            Arel::Nodes::NamedFunction.new('row_number', []),
            window
            
          share_size = 
            Arel::Nodes::NamedFunction.new('convert', [Arel.sql('numeric(20,2)'), Source.moveitems[:square]])
          
          manager = Arel::SelectManager.new 
          manager.project(
            subquery_table[:___paycard_id],
            subquery_table[:moveitem_id],
            Source.moveitems[:object_id],
            subquery_table[:func_using_id],
            part_num.as("part_num"),
            Source.usingprupose[:name].as("part_name"),
            subquery_table[:area1],  
            share_size.as("share_size"),
            Source.moveitems[:share_num].as("numerator"),
            Source.moveitems[:share_denom].as("denominator"),
          )
          manager.from(subquery_table)
          manager.join(Source.___paycards).on(Source.___paycards[:id].eq(subquery_table[:___paycard_id]))
          manager.join(Source.moveitems).on(Source.moveitems[:id].eq(subquery_table[:moveitem_id]))
          manager.join(Source.objectusing, Arel::Nodes::OuterJoin).on(Source.objectusing[:moveitem_id].eq(subquery_table[:moveitem_id]))
          manager.join(Source.usingprupose, Arel::Nodes::OuterJoin).on(Source.usingprupose[:id].eq(Source.objectusing[:usingpurpose]))
        end

        begin
          sql = ""
          insert = []

          Source.execute_query(query.to_sql).each_slice(1000) do |rows|
          
            rows.each do |row|
              insert << {
                ___paycard_id: row["___paycard_id"],
                moveitem_id: row["moveitem_id"],
                object_id: row["object_id"],
                func_using_id: row["func_using_id"],
                part_num: row["part_num"],
                part_name: row["part_name"],
                area1: row["area1"],
                share_size: row["share_size"],
                numerator: row["numerator"],
                denominator: row["denominator"],
              }
            end

            condition =<<~SQL
              ___paycardobjects.___paycard_id = values_table.___paycard_id
                and ___paycardobjects.moveitem_id = values_table.moveitem_id
                and ___paycardobjects.object_id = values_table.object_id
                and ___paycardobjects.part_num = values_table.part_num
            SQL

            sql = Source::Paycardobjects.insert_query(rows: insert, condition: condition)
            result = Source.execute_query(sql)
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
