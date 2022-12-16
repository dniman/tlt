namespace :corrs do
  namespace :source do
    namespace :___ids do

      task :update___link do |t|
        def query
          Destination.s_corr
          .project(
            Destination.mss_objcorr[:link].as("___link"),
            Destination.s_corr[:row_id], 
          )
          .join(Destination.mss_objcorr).on(Destination.mss_objcorr[:link_s_corr].eq(Destination.s_corr[:link]))
          .where(Destination.s_corr[:object].eq(Destination::SCorr::DICTIONARY_CORR))
        end

        begin
          Destination.execute_query(query.to_sql).each_slice(1000) do |rows|
          
            columns = rows.map(&:keys).uniq.flatten
            values_list = Arel::Nodes::ValuesList.new(rows.map(&:values))
        
            sql = <<~SQL
              update ___ids set 
                ___ids.___link = values_table.___link
              from(#{values_list.to_sql}) values_table(#{columns.join(', ')})
              where ___ids.row_id = values_table.row_id  
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
