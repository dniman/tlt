namespace :corrs do
  namespace :source do
    namespace :ids do

      task :update_link do |t|
        def query
          Destination.set_engine!
          query =
            Destination.s_corr
            .project(
              Destination.s_corr[:link], 
              Destination.s_corr[:row_id], 
              Destination.mss_objcorr[:link].as("___link")
            )
            .join(Destination.mss_objcorr).on(Destination.mss_objcorr[:link_s_corr].eq(Destination.s_corr[:link]))
            .where(Destination.s_corr[:object].eq(Destination::SCorr::DICTIONARY_CORR))
        end

        begin
          sliced_rows = Destination.execute_query(query.to_sql).each_slice(1000).to_a
          sliced_rows.each do |rows|
            columns = rows.map(&:keys).uniq.flatten
            values_list = Arel::Nodes::ValuesList.new(rows.map(&:values))
        
            sql = <<~SQL
              update ids set 
                ids.link = values_table.link
                ,ids.___link = values_table.___link
              from(#{values_list.to_sql}) values_table(#{columns.join(', ')})
              where ids.row_id = values_table.row_id  
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
