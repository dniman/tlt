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

          # not exists
          subquery2 = Arel::SelectManager.new Database.source_engine
          subquery2.project(Arel.star)
          subquery2.from(Source.___paycardobjects)
          subquery2.where(
            Source.___paycardobjects[:___paycard_id].eq(subquery_table[:___paycard_id])
            .and(Source.___paycardobjects[:moveitem_id].eq(subquery_table[:moveitem_id]))
            .and(Source.___paycardobjects[:object_id].eq(Source.moveitems[:object_id]))
            .and(Source.___paycardobjects[:objectusing_id].eq(Source.objectusing[:id]))
          )
          
          window = Arel::Nodes::Window.new.tap do |w|
            w.partition(Source.___paycards[:id], Source.___paycards[:moveperiod_id])
            w.order(Source.___paycards[:___order], subquery_table[:moveitem_id], Source.objectusing[:id])
          end

          part_num = Arel::Nodes::Over.new \
            Arel::Nodes::NamedFunction.new('row_number', []),
            window
            
          share_size = 
            Arel::Nodes::NamedFunction.new('convert', [Arel.sql('numeric(20,2)'), Source.moveitems[:square]])
          
          select_manager = Arel::SelectManager.new 
          select_manager.project(
            subquery_table[:___paycard_id],
            subquery_table[:moveitem_id],
            Source.moveitems[:object_id],
            Source.objectusing[:id].as("objectusing_id"),
            subquery_table[:func_using_id],
            part_num.as("part_num"),
            Source.usingprupose[:name].as("part_name"),
            subquery_table[:area1],  
            share_size.as("share_size"),
            Source.moveitems[:share_num].as("numerator"),
            Source.moveitems[:share_denom].as("denominator"),
          )
          select_manager.from(subquery_table)
          select_manager.join(Source.___paycards).on(Source.___paycards[:id].eq(subquery_table[:___paycard_id]))
          select_manager.join(Source.moveitems).on(Source.moveitems[:id].eq(subquery_table[:moveitem_id]))
          select_manager.join(Source.objectusing, Arel::Nodes::OuterJoin).on(Source.objectusing[:moveitem_id].eq(subquery_table[:moveitem_id]))
          select_manager.join(Source.usingprupose, Arel::Nodes::OuterJoin).on(Source.usingprupose[:id].eq(Source.objectusing[:usingpurpose]))
          select_manager.where(subquery2.exists.not)
          
          source = Arel::Nodes::JoinSource.new(select_manager,[])

          insert_manager = Arel::InsertManager.new Database.source_engine
          insert_manager.columns << Source.___paycardobjects[:___paycard_id] 
          insert_manager.columns << Source.___paycardobjects[:moveitem_id]
          insert_manager.columns << Source.___paycardobjects[:object_id]
          insert_manager.columns << Source.___paycardobjects[:objectusing_id]
          insert_manager.columns << Source.___paycardobjects[:func_using_id]
          insert_manager.columns << Source.___paycardobjects[:part_num]
          insert_manager.columns << Source.___paycardobjects[:part_name]
          insert_manager.columns << Source.___paycardobjects[:area1]
          insert_manager.columns << Source.___paycardobjects[:share_size]
          insert_manager.columns << Source.___paycardobjects[:numerator]
          insert_manager.columns << Source.___paycardobjects[:denominator]
          insert_manager.into(Source.___paycardobjects)
          insert_manager.select(source)
          insert_manager.to_sql
        end

        begin
          Source.execute_query(query).do

          Rake.info "Задача '#{ t }' успешно выполнена."
        rescue StandardError => e
          Rake.error "Ошибка при выполнении задачи '#{ t }' - #{e}."
          Rake.info "Текст запроса \"#{ query }\""

          exit
        end
      end

    end
  end
end
