namespace :moving_operations do
  namespace :source do
    namespace :___ids do

      task :insert do |t|
        def query
          mss_v_moves_types_query =
            Destination.mss_v_moves_types 
            .project([
              Destination.mss_v_moves_types[:link],
              Destination.mss_v_moves_types[:name],
            ])

          mss_v_moves_types = Destination.execute_query(agreements_types_query.to_sql).to_a
          link_type =
            Arel::Nodes::Case.new(Source.___moving_operations[:movetype_name])
              .when('Собственность').then(mss_v_moves_types.select{|r| r["name"] == 'Собственность'}.first["link"])
              .when('Балансодержание').then(mss_v_moves_types.select{|r| r["name"] == 'Правообладание'}.first["link"])
              .when('Пользование').then(mss_v_moves_types.select{|r| r["name"] == 'Постоянное (бессрочное) пользование'}.first["link"])
              .when('Аренда').then(mss_v_moves_types.select{|r| r["name"] == 'Аренда'}.first["link"])
              .when('Субаренда').then(mss_v_moves_types.select{|r| r["name"] == 'Субаренда'}.first["link"])
              .when('Строительство').then(mss_v_moves_types.select{|r| r["name"] == 'Строительство'}.first["link"])
              .when('Приватизация').then(mss_v_moves_types.select{|r| r["name"] == 'Приватизация'}.first["link"])
              .when('Обслуживание').then(mss_v_moves_types.select{|r| r["name"] == 'Обслуживание'}.first["link"])
              .when('Рента').then(mss_v_moves_types.select{|r| r["name"] == 'Рента'}.first["link"])
              .when('Казна').then(mss_v_moves_types.select{|r| r["name"] == 'Казна'}.first["link"])
              .when('Арендный фонд').then(mss_v_moves_types.select{|r| r["name"] == 'Арендный фонд'}.first["link"])
              .when('Залог').then(mss_v_moves_types.select{|r| r["name"] == 'Залог'}.first["link"])
              .when('Залоговый фонд').then(mss_v_moves_types.select{|r| r["name"] == 'Залоговый фонд'}.first["link"])
              .when('Охрана').then(mss_v_moves_types.select{|r| r["name"] == 'Охрана'}.first["link"])
              .when('Страхование').then(mss_v_moves_types.select{|r| r["name"] == 'Страхование'}.first["link"])
              .when('Доверительное управление').then(mss_v_moves_types.select{|r| r["name"] == 'Доверительное управление'}.first["link"])
              .when('Жилой фонд').then(mss_v_moves_types.select{|r| r["name"] == 'Жилищный фонд'}.first["link"])
              .when('Списание').then(mss_v_moves_types.select{|r| r["name"] == 'Исключение из реестра'}.first["link"])
              .when('Ликвидация').then(mss_v_moves_types.select{|r| r["name"] == 'Исключение из реестра'}.first["link"])
              .when('Бессрочное пользование').then(mss_v_moves_types.select{|r| r["name"] == 'Постоянное (бессрочное) пользование'}.first["link"])
              .when('Сервитут').then(mss_v_moves_types.select{|r| r["name"] == 'Сервитут'}.first["link"])
              .when('Безвозмездное пользование').then(mss_v_moves_types.select{|r| r["name"] == 'Безвозмездное пользование'}.first["link"])
              .when('Наследуемое владение').then(mss_v_moves_types.select{|r| r["name"] == 'Пожизненное наследуемое владение'}.first["link"])
              .when('Арест').then(mss_v_moves_types.select{|r| r["name"] == 'Арест'}.first["link"])
              .when('Размещение').then(mss_v_moves_types.select{|r| r["name"] == 'Иное ограничение (обременение)'}.first["link"])
              .when('Аренда балансодержателей').then(mss_v_moves_types.select{|r| r["name"] == 'Аренда'}.first["link"])
              .when('Фактическое пользование').then(mss_v_moves_types.select{|r| r["name"] == 'Неосновательное обогащение'}.first["link"])
              .when('Фонд особо ценного имущества').then(mss_v_moves_types.select{|r| r["name"] == 'Особо ценное имущество'}.first["link"])
              .when('Безв.польз.балансодержателей').then(mss_v_moves_types.select{|r| r["name"] == 'Безвозмездное пользование'}.first["link"])
              .when('Запасной вариант').then(mss_v_moves_types.select{|r| r["name"] == 'Иное ограничение (обременение)'}.first["link"])
              .when('Купля-продажа').then(mss_v_moves_types.select{|r| r["name"] == 'Собственность'}.first["link"])
              .when('Концессия').then(mss_v_moves_types.select{|r| r["name"] == 'Концессия'}.first["link"])
              .when('Охранное обязательство').then(mss_v_moves_types.select{|r| r["name"] == 'Охрана'}.first["link"])
              .when('Аренда ОРПР').then(mss_v_moves_types.select{|r| r["name"] == 'Аренда'}.first["link"])

          subquery = Arel::SelectManager.new Database.source_engine
          subquery.project(Arel.star)
          subquery.from(Source.___ids)
          subquery.where(
            Source.___ids[:id].eq(Source.___moving_operations[:id])
            .and(Source.___ids[:table_id].eq(Source::MovingOperations.table_id))
          )
           
          select_manager = Arel::SelectManager.new
          select_manager.project([
            Arel.sql("#{Source::MovingOperations.table_id}").as("table_id"),
            Source.___moving_operations[:id],
            link_type.as("link_type"),
            Arel::Nodes::NamedFunction.new('newid', []).as("row_id")
          ])
          select_manager.from(Source.___moving_operations)
          select_manager.where(subquery.exists.not)
          
          source = Arel::Nodes::JoinSource.new(select_manager,[])

          insert_manager = Arel::InsertManager.new Database.source_engine
          insert_manager.columns << Source.___ids[:table_id] 
          insert_manager.columns << Source.___ids[:id]
          insert_manager.columns << Source.___ids[:link_type]
          insert_manager.columns << Source.___ids[:row_id]
          insert_manager.into(Source.___ids)
          insert_manager.select(source)
          insert_manager.to_sql
        end
        
        begin
          Source.execute_query(query).do

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
