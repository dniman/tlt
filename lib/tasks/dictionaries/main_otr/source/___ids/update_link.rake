namespace :dictionaries do
  namespace :main_otr do
    namespace :source do
      namespace :___ids do

        task :update_link do |t|
          def link_prop_query
            Destination.mss_objcorr_props
            .project(
              Destination.mss_objcorr_props[:link]
            )
            .where(Destination.mss_objcorr_props[:code].eq('MAIN_OTR'))
          end

          def query
            link_prop = Destination.execute_query(link_prop_query.to_sql).entries.first["link"]

            Destination.mss_objcorr_dictsimptext
            .project(
              Destination.mss_objcorr_dictsimptext[:link], 
              Destination.mss_objcorr_dictsimptext[:value].as("name"), 
            )
            .where(Destination.mss_objcorr_dictsimptext[:link_prop].eq(link_prop))
          end

          begin
            sql = ""

            Destination.execute_query(query.to_sql).each_slice(1000) do |rows|
              columns = rows.map(&:keys).uniq.flatten
              values_list = Arel::Nodes::ValuesList.new(rows.map(&:values))
          
              sql = <<~SQL
                update ___ids set 
                  ___ids.link = values_table.link
                from ___ids
                  join ___main_otrs on ___main_otrs.id = ___ids.id and ___ids.table_id = #{ Source::MainOtrs.table_id }
                  join (#{values_list.to_sql}) values_table(#{columns.join(', ')}) on values_table.name = ___main_otrs.name
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
