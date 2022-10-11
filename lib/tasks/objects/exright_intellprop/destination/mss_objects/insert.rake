namespace :objects do
  namespace :exright_intellprop do
    namespace :destination do
      namespace :mss_objects do

        task :insert do |t|
          def link_type_query
            Destination.set_engine!
            query = 
              Destination.mss_objects_types 
              .project(Destination.mss_objects_types[:link])
              .where(Destination.mss_objects_types[:code].eq("EXRIGHT_INTELLPROP"))
          end

          def query
            link_type = Destination.execute_query(link_type_query.to_sql).entries.first["link"]

            Source.set_engine!

            Source.objects
            .project([
              Source.objects[:description],
              Source.objects[:invno],
              Source.ids[:row_id],
              Source.ids[:link_type],
              Source.intellect[:name],
              Source.intellectualtypes[:name].as("___intellprop_sp"),
              Arel.sql(
                "ltrim(rtrim(
                    replace(replace([intellect].[func_nazn], char(9), ''), char(10), '')
                  ))"
              ).as("___func_nazn_ei"),
              Source.clients[:name].as("___storage_authority_ei"),
              Source.statetypes[:name].as("___state"),
              Source.states[:calcdate].as("___state_date"),
            ])
            .join(Source.objtypes, Arel::Nodes::OuterJoin).on(Source.objtypes[:id].eq(Source.objects[:objtypes_id]))
            .join(Source.ids).on(Source.ids[:id].eq(Source.objects[:id]).and(Source.ids[:table_id].eq(Source::Objects.table_id)))
            .join(Source.intellect, Arel::Nodes::OuterJoin).on(Source.intellect[:objects_id].eq(Source.objects[:id]))
            .join(Source.intellectualtypes, Arel::Nodes::OuterJoin).on(Source.intellectualtypes[:id].eq(Source.intellect[:intell_type_id]))
            .join(Source.clients, Arel::Nodes::OuterJoin).on(Source.clients[:id].eq(Source.intellect[:clients_id]))
            .join(Source.states, Arel::Nodes::OuterJoin).on(Source.states[:objects_id].eq(Source.objects[:id]))
            .join(Source.statetypes, Arel::Nodes::OuterJoin).on(Source.statetypes[:id].eq(Source.states[:statetypes_id]))
            .where(Source.ids[:link_type].eq(link_type))
          end

          begin
            sql = ""
            insert = []
            sliced_rows = Source.execute_query(query.to_sql).each_slice(1000).to_a
            sliced_rows.each do |rows|
              rows.each do |row|
                insert << {
                  name: (row["name"].nil? || row["name"].strip.empty?) ? row["description"]&.strip : row["name"]&.strip,
                  inventar_num: row["invno"]&.strip,
                  inventar_num_date: nil,
                  link_type: row["link_type"],
                  link_mo: Destination.link_mo,
                  link_oktmo: nil,
                  object: Destination::MssObjects::DICTIONARY_MSS_OBJECTS,
                  row_id: row["row_id"],
                  ___intellprop_sp: row["___intellprop_sp"]&.strip,
                  ___func_nazn_ei: row["___func_nazn_ei"]&.strip,
                  ___storage_authority_ei: row["___storage_authority_ei"]&.strip,
                  ___state: row["___state"]&.strip,
                  ___state_date: row["___state_date"],
                }
              end

              condition =<<~SQL
                mss_objects.row_id = values_table.row_id
              SQL

              sql = Destination::MssObjects.insert_query(rows: insert, condition: condition)
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
