namespace :paycards do
  namespace :source do
    namespace :___paycards do

      task :update___name_objtype do |t|

        def query
          manager = Arel::SelectManager.new(Database.source_engine)
          manager.project([
            Source.___paycards[:id],
            Source.objtypes[:name].as("___name_objtype"),
          ])
          manager.from(Source.moveitems)
          manager.join(Source.___paycards).on(Source.___paycards[:moveperiod_id].eq(Source.moveitems[:moveperiod_id]))
          manager.join(Source.objects).on(Source.objects[:id].eq(Source.moveitems[:object_id]))
          manager.join(Source.objtypes).on(Source.objtypes[:id].eq(Source.objects[:objtypes_id]))
        end

        begin
          Source.execute_query(query.to_sql).each_slice(1000) do |rows|
          
            columns = rows.map(&:keys).uniq.flatten
            values_list = Arel::Nodes::ValuesList.new(rows.map(&:values))
        
            sql = <<~SQL
              update ___paycards set 
                ___paycards.___name_objtype = values_table.___name_objtype
              from(#{values_list.to_sql}) values_table(#{columns.join(', ')})
              where ___paycards.id = values_table.id
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
