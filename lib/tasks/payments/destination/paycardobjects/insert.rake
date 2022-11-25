namespace :payments do
  namespace :destination do
    namespace :paycardobjects do

      task :insert do |t|
        def len
          Arel::Nodes::NamedFunction.new('len', [ Source.___paycardobjects[:part_num] ]) 
        end

        def query 
          paycards = Source.___ids.alias("paycards")
          objects = Source.___ids.alias("objects")
          nazn = Source.___ids.alias("nazn")

          Source.___paycardobjects
          .project([
            paycards[:link].as("link_pc"),
            objects[:link].as("link_obj"),
            Source.___paycardobjects[:area1],
            Source.___paycards[:summa2],
            nazn[:link].as("nazn"),
            Source.___paycardobjects[:share_size],
            Source.___paycardobjects[:numerator],
            Source.___paycardobjects[:denominator],
            Source.___paycardobjects[:part_num],
            Source.___paycardobjects[:part_name],
            Source.___ids[:row_id],
          ])
          .join(Source.___ids).on(Source.___ids[:id].eq(Source.___paycardobjects[:id]).and(Source.___ids[:table_id].eq(Source::Paycardobjects.table_id)))
          .join(paycards).on(paycards[:id].eq(Source.___paycardobjects[:___paycard_id]).and(paycards[:table_id].eq(Source::Paycards.table_id)))
          .join(objects).on(objects[:id].eq(Source.___paycardobjects[:object_id]).and(objects[:table_id].eq(Source::Objects.table_id)))
          .join(Source.___paycards).on(Source.___paycards[:id].eq(Source.___paycardobjects[:___paycard_id]))
          .join(nazn, Arel::Nodes::OuterJoin).on(nazn[:id].eq(Source.___paycardobjects[:func_using_id]).and(nazn[:table_id].eq(Source::FuncUsing.table_id)))
          .order([paycards[:link], len, Source.___paycardobjects[:part_num]]) 
        end
        
        begin
          sql = ""
          insert = []

          sliced_rows = Source.execute_query(query.to_sql).each_slice(1000).to_a
          sliced_rows.each do |rows|
            rows.each do |row|
              insert << {
                link_pc: row["link_pc"],
                link_obj: row["link_obj"],
                area1: row["area1"],
                summa2: row["summa2"],
                nazn: row["nazn"],
                share_size: row["share_size"],
                numerator: row["numerator"],
                denominator: row["denominator"],
                part_num: row["part_num"],
                part_name: row["part_name"],
                row_id: row["row_id"],
              }
            end
            sql = Destination::Paycardobjects.insert_query(rows: insert, condition: "paycardobjects.row_id = values_table.row_id")
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
