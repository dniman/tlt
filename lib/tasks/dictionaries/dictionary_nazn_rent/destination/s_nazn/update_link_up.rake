namespace :dictionaries do
  namespace :dictionary_nazn_rent do
    namespace :destination do
      namespace :s_nazn do

        task :update_link_up do |t|
          def query
            cte_table = Arel::Table.new(:cte_table)
            
            select_one = 
              Source.func_using
              .project(
                Source.func_using[:id],
                Source.func_using[:root].as("parent_id"),
                Source.___ids[:link],
                Arel::Nodes::SqlLiteral.new('0').as("link_up")
              )
              .join(Source.___ids).on(Source.___ids[:id].eq(Source.func_using[:id]).and(Source.___ids[:table_id].eq(Source::FuncUsing.table_id)))
              .where(Source.func_using[:root].eq(nil))

            select_two = 
              Source.func_using
              .project([
                Source.func_using[:id],
                cte_table[:id].as("parent_id"),
                Source.___ids[:link],
                Arel::Nodes::NamedFunction.new('convert', [ Arel.sql('int'), cte_table[:link] ]).as("link_up")
              ])
              .join(cte_table).on(cte_table[:id].eq(Source.func_using[:root]))
              .join(Source.___ids).on(Source.___ids[:id].eq(Source.func_using[:id]).and(Source.___ids[:table_id].eq(Source::FuncUsing.table_id)))

            union = Arel::Nodes::UnionAll.new(select_one, select_two)
            func_using_cte = Arel::Nodes::As.new(cte_table, union)
            
            manager = Arel::SelectManager.new Database.source_engine
            manager.project(
              cte_table[:link],
              cte_table[:link_up],
            )
            manager.from(cte_table)
            manager.with(func_using_cte)
            manager.where(cte_table[:link_up].gt(0))
          end

          begin
            sliced_rows = Source.execute_query(query.to_sql).each_slice(1000).to_a
            sliced_rows.each do |rows|
              columns = rows.map(&:keys).uniq.flatten
              values_list = Arel::Nodes::ValuesList.new(rows.map(&:values))
          
              sql = <<~SQL
                update s_nazn set 
                  s_nazn.link_up = values_table.link_up
                from(#{values_list.to_sql}) values_table(#{columns.join(', ')})
                where s_nazn.link = values_table.link
              SQL
              result = Destination.execute_query(sql)
              result.do
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
