namespace :corrs do
  namespace :fl_pers do
    namespace :source do
      namespace :___ids do

        task :update___doc_type_name do |t|
          def query
            ___doc_type_name =
              Arel::Nodes::Case.new
              .when(Source.privdoctypes[:name].eq('Паспорт гражданина СССР')).then('Паспорт гражданина СССР')
              .when(Source.privdoctypes[:name].eq('Паспорт гражданина России')).then('Паспорт гражданина Российской Федерации')
              .when(Source.privdoctypes[:name].eq('01')).then('Паспорт гражданина Российской Федерации')
              .when(Source.privdoctypes[:name].eq('паспорт')).then('Паспорт гражданина Российской Федерации')
              .when(Source.privdoctypes[:name].eq('свидетельство о рождении')).then('Свидетельство о рождении')
              .when(Source.privdoctypes[:name].eq('Паспорт иностранного гражданина')).then('Паспорт иностранного гражданина')
              .when(Source.privdoctypes[:name].eq('Вид на жительство иностранного гражданина')).then('Вид на жительство иностранного гражданина')

            Source.privates
            .project(
              Source.privates[:id],
              ___doc_type_name.as("___doc_type_name"),
            )
            .join(Source.privdoctypes).on(Source.privdoctypes[:id].eq(Source.privates[:privdoctypes_id]))
          end

          begin
            sql = ""

            Source.execute_query(query.to_sql).each_slice(1000) do |rows|
              columns = rows.map(&:keys).uniq.flatten
              values_list = Arel::Nodes::ValuesList.new(rows.map(&:values))
          
              sql = <<~SQL
                update ___ids set 
                  ___ids.___doc_type_name = values_table.___doc_type_name
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
