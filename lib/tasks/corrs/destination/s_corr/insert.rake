namespace :corrs do
  namespace :destination do
    namespace :s_corr do

      task :insert do |t|
        def query
          select_one = 
            Source.clients
            .project([
              Source.___ids[:row_id][-7..-1].as("code"),
              Source.clients[:inn],
              Source.clients[:name].as("sname"),
              Source.privates[:fullname].as("name"),
              Arel.sql("#{ Destination::SCorr::DICTIONARY_CORR }").as("object"),
              Source.___ids[:row_id],
            ])
            .join(Source.___ids).on(Source.___ids[:id].eq(Source.clients[:id]).and(Source.___ids[:table_id].eq(Source::Clients.table_id)))
            .join(Source.client_types, Arel::Nodes::OuterJoin).on(Source.client_types[:id].eq(Source.clients[:client_types_id]))
            .join(Source.privates, Arel::Nodes::OuterJoin).on(Source.privates[:clients_id].eq(Source.clients[:id]))
            .where(Source.client_types[:name].eq('Физическое лицо'))

          select_two =
            Source.clients
            .project([
              Arel.sql("null").as("code"),
              Source.clients[:inn],
              Source.clients[:name].as("sname"),
              Source.organisations[:name],
              Arel.sql("#{ Destination::SCorr::DICTIONARY_CORR }").as("object"),
              Source.___ids[:row_id],
            ])
            .join(Source.___ids).on(Source.___ids[:id].eq(Source.clients[:id]).and(Source.___ids[:table_id].eq(Source::Clients.table_id)))
            .join(Source.client_types, Arel::Nodes::OuterJoin).on(Source.client_types[:id].eq(Source.clients[:client_types_id]))
            .join(Source.organisations, Arel::Nodes::OuterJoin).on(Source.organisations[:clients_id].eq(Source.clients[:id]))
            .where(Source.client_types[:name].eq('Юридическое лицо'))

          union = select_one.union :all, select_two
          union_table = Arel::Table.new :union_table

          manager = Arel::SelectManager.new
          manager.project(Arel.star)
          manager.from(union_table.create_table_alias(union,:union_table))
        end

        begin
          sql = ""
          insert = []
          Source.execute_query(query.to_sql).each_slice(1000) do |rows|
            rows.each do |row|
              insert << {
                code: row["code"],
                inn: row["inn"].nil? ? nil : row["inn"].strip[0,13],
                sname: row["sname"].nil? ? row["name"].strip[0, 160] : row["sname"].strip[0,160],
                name: row["name"].nil? ? row["sname"].strip[0, 250] : row["name"].strip[0,250],
                object: row["object"],
                row_id: row["row_id"],
              }
            end

            sql = Destination::SCorr.insert_query(rows: insert, condition: "s_corr.row_id = values_table.row_id")
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
