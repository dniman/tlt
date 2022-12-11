namespace :paycards do
  namespace :source do
    namespace :___paycards do

      task :update___payer_type do |t|

        def query
          corr = Destination.s_corr.alias("corr")
          inn = 
            Destination.s_corr
            .project(Destination.s_corr[:inn])
            .join(Destination.t_corr_dict, Arel::Nodes::OuterJoin).on(
              Destination.t_corr_dict[:corr_dict].eq(Destination.s_corr[:link])
              .and(Destination.s_corr[:object].eq(Destination::SCorr::DICTIONARY_CORR_TYPE))
              .and(Destination.t_corr_dict[:object].eq(Destination::TCorrDict::REFERENCE_CORR_TYPE))
            )
            .where(Destination.t_corr_dict[:corr].eq(corr[:link]))
            .order(Arel::Nodes::Case.new(Destination.s_corr[:inn])
              .when('UL').then(1)
              .when('FL').then(2)
              .when('FL_PERS').then(3)
              .else(4)
            )
            .take(1)

          manager = Arel::SelectManager.new(Database.destination_engine)
          manager.project([
            corr[:link].as("___corr1"),
            inn.as("___payer_type"),
          ])
          manager.from(corr)
          manager.where(corr[:object].eq(Destination::SCorr::DICTIONARY_CORR))
        end

        begin
          Destination.execute_query(query.to_sql).each_slice(1000) do |rows|
          
            columns = rows.map(&:keys).uniq.flatten
            values_list = Arel::Nodes::ValuesList.new(rows.map(&:values))
        
            sql = <<~SQL
              update ___paycards set 
                ___paycards.___payer_type = values_table.___payer_type
              from(#{values_list.to_sql}) values_table(#{columns.join(', ')})
              where ___paycards.___corr1 = values_table.___corr1
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
