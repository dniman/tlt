namespace :corrs do
  namespace :destination do
    namespace :t_corr_dict do
      namespace :reference_corr_type do

        task :insert do |t|
          def link_type_query(code)
            Destination.set_engine!
            query = 
              Destination.s_corr
              .project(Destination.s_corr[:link])
              .where(Destination.s_corr[:inn].eq(code)
                .and(Destination.s_corr[:object].eq(Destination::SCorr::DICTIONARY_CORR_TYPE))
              )
          end

          def query
            fl_pers = Destination.execute_query(link_type_query('FL_PERS').to_sql).entries.first["link"]
            fl = Destination.execute_query(link_type_query('FL').to_sql).entries.first["link"]
            ul = Destination.execute_query(link_type_query('UL').to_sql).entries.first["link"]

            Source.set_engine!

            select_one = 
              Source.clients
              .project([
                Source.ids[:link],
                Arel.sql(fl_pers.to_s).as("corr_dict"),
              ])
              .join(Source.ids).on(Source.ids[:id].eq(Source.clients[:id]).and(Source.ids[:table_id].eq(Source::Clients.table_id)))
              .join(Source.client_types, Arel::Nodes::OuterJoin).on(Source.client_types[:id].eq(Source.clients[:client_types_id]))
              .join(Source.privates, Arel::Nodes::OuterJoin).on(Source.privates[:clients_id].eq(Source.clients[:id]))
              .where(Source.client_types[:name].eq('Физическое лицо'))

            select_two =
              Source.clients
              .project([
                Source.ids[:link],
                Arel.sql(ul.to_s).as("corr_dict"),
              ])
              .join(Source.ids).on(Source.ids[:id].eq(Source.clients[:id]).and(Source.ids[:table_id].eq(Source::Clients.table_id)))
              .join(Source.client_types, Arel::Nodes::OuterJoin).on(Source.client_types[:id].eq(Source.clients[:client_types_id]))
              .join(Source.organisations, Arel::Nodes::OuterJoin).on(Source.organisations[:clients_id].eq(Source.clients[:id]))
              .where(Source.client_types[:name].eq('Юридическое лицо'))

            select_three = 
              Source.clients
              .project([
                Source.ids[:link],
                Arel.sql(fl.to_s).as("corr_dict"),
              ])
              .join(Source.ids).on(Source.ids[:id].eq(Source.clients[:id]).and(Source.ids[:table_id].eq(Source::Clients.table_id)))
              .join(Source.client_types, Arel::Nodes::OuterJoin).on(Source.client_types[:id].eq(Source.clients[:client_types_id]))
              .join(Source.privates, Arel::Nodes::OuterJoin).on(Source.privates[:clients_id].eq(Source.clients[:id]))
              .where(Source.client_types[:name].eq('Физическое лицо')
                .and(Source.clients[:name].matches("% ИП")
                  .or(Source.clients[:name].matches("ИП %"))
                )
              )

            union = Arel::Nodes::Union.new(Arel::Nodes::Union.new(select_one, select_two), select_three)

            #union = select_one.union :all, select_two
            union_table = Arel::Table.new :union_table

            manager = Arel::SelectManager.new
            manager.project(Arel.star)
            manager.from(union_table.create_table_alias(union,:union_table))
          end

          begin
            sql = ""
            insert = []
            sliced_rows = Source.execute_query(query.to_sql).each_slice(1000).to_a
            sliced_rows.each do |rows|
              rows.each do |row|
                insert << {
                  corr_dict: row["corr_dict"],
                  corr: row["link"],
                  object: Destination::TCorrDict::REFERENCE_CORR_TYPE,
                }
              end

              condition =<<~SQL
                t_corr_dict.corr_dict = values_table.corr_dict
                  and t_corr_dict.corr = values_table.corr
                  and t_corr_dict.object = values_table.object
              SQL

              sql = Destination::TCorrDict.insert_query(rows: insert, condition: condition)
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
