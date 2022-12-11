namespace :objects do
  namespace :partnership do
    namespace :destination do
      namespace :t_corr_dict do
        namespace :reference_corr_type do
          namespace :partnership do

            task :delete do |t|
              def link_corr_type_query(code)
                Destination.s_corr
                .project(Destination.s_corr[:link])
                .where(Destination.s_corr[:inn].eq(code)
                  .and(Destination.s_corr[:object].eq(Destination::SCorr::DICTIONARY_CORR_TYPE))
                )
              end

              def query
                partnership = Destination.execute_query(link_corr_type_query('PARTNERSHIP').to_sql).entries.first["link"]

                condition1 = Destination.t_corr_dict.create_on(Destination.mss_objects[:link_corr].eq(Destination.t_corr_dict[:corr]))
                condition2 = Destination.___del_ids.create_on(
                  Destination.___del_ids[:row_id].eq(Destination.mss_objects[:row_id])
                  .and(Destination.___del_ids[:table_id].eq(Source::Objects.table_id))
                )

                source = Arel::Nodes::JoinSource.new(
                  Destination.t_corr_dict, [
                    Destination.t_corr_dict.create_join(Destination.mss_objects, condition1),
                    Destination.mss_objects.create_join(Destination.___del_ids, condition2),
                  ]
                )
                
                manager = Arel::DeleteManager.new Database.destination_engine
                manager.from(source)
                manager.where(
                  Destination.t_corr_dict[:corr_dict].eq(partnership)
                  .and(Destination.t_corr_dict[:object].eq(Destination::SObjects.obj_id('REFERENCE_CORR_TYPE')))
                )
                manager.to_sql
              end

              begin
                Destination.execute_query(query).do
                
                Rake.info "Задача '#{ t }' успешно выполнена."
              rescue StandardError => e
                Rake.error "Ошибка при выполнении задачи '#{ t }' - #{e}."
                Rake.info "Текст запроса \"#{ query }\""

                exit
              end
            end
          
          end
        end
      end
    end
  end
end
