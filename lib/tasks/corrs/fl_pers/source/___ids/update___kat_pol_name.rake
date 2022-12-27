namespace :corrs do
  namespace :fl_pers do
    namespace :source do
      namespace :___ids do

        task :update___kat_pol_name do |t|
          def query
            Source.clients
            .project(
              Source.clients[:id],
              Source.category_client[:name].as("___kat_pol_name"),
            )
            .join(Source.client_types, Arel::Nodes::OuterJoin).on(Source.client_types[:id].eq(Source.clients[:client_types_id]))
            .join(Source.category_client, Arel::Nodes::OuterJoin).on(Source.category_client[:id].eq(Source.clients[:clientcategory_id]))
            .where(Source.client_types[:name].eq('Физическое лицо'))
          end

          begin
            sql = ""

            Source.execute_query(query.to_sql).each_slice(1000) do |rows|
              columns = rows.map(&:keys).uniq.flatten
              values_list = Arel::Nodes::ValuesList.new(rows.map(&:values))
          
              sql = <<~SQL
                update ___ids set 
                  ___ids.___kat_pol_name = values_table.___kat_pol_name
                from(#{values_list.to_sql}) values_table(#{columns.join(', ')})
                where ___ids.id = values_table.id
              SQL
              result = Source.execute_query(sql)
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
