namespace :moving_operations do
  namespace :destination do
    namespace :mss_movs do

      task :insert do |t|
        def gr_num_by_doctype_name(name)
          manager = Arel::SelectManager.new Database.source_engine
          manager.project(Source.documents[:gr_num])
          manager.from(Source.docset_members)
          manager.join(Source.documents).on(Source.documents[:id].eq(Source.docset_members[:document_id]))
          manager.join(Source.doctypes, Arel::Nodes::OuterJoin).on(Source.doctypes[:id].eq(Source.documents[:doctypes_id]))
          manager.where(
            Source.docset_members[:docset_id].eq(Source.___moving_operations[:docset_id])
            .and(Source.doctypes[:name].eq(name))
            .and(Source.documents[:gr_num].not_eq(nil))
            .and(Source.documents[:gr_date].not_eq(nil))
          )
          manager.take(1)
        end
        
        def gr_date_by_doctype_name(name)
          gr_date =
            Arel::Nodes::Case.new()
            .when(Source.documents[:gr_date].gteq('17530101')).then(Source.documents[:gr_date])
            
          manager = Arel::SelectManager.new Database.source_engine
          manager.project(gr_date.as("gr_date"))
          manager.from(Source.docset_members)
          manager.join(Source.documents).on(Source.documents[:id].eq(Source.docset_members[:document_id]))
          manager.join(Source.doctypes, Arel::Nodes::OuterJoin).on(Source.doctypes[:id].eq(Source.documents[:doctypes_id]))
          manager.where(
            Source.docset_members[:docset_id].eq(Source.___moving_operations[:docset_id])
            .and(Source.doctypes[:name].eq(name))
            .and(Source.documents[:gr_num].not_eq(nil))
            .and(Source.documents[:gr_date].not_eq(nil))
          )
          manager.take(1)
        end

        def query

          num_reg =
            Arel::Nodes::Case.new()
            .when(Source.___moving_operations[:movetype_name].in(['Собственность','Купля-продажа']))
            .then(
              Arel::Nodes::NamedFunction.new('coalesce', [ 
                gr_num_by_doctype_name('Запись о регистрации права муниципальной собственности'),
                gr_num_by_doctype_name('Свидетельство муниципальной собственности'),
                gr_num_by_doctype_name('Выписка из ЕГРН'),
              ]) 
            )
            .when(Source.___moving_operations[:movetype_name].in(['Пользование', 'Бессрочное пользование']))
            .then(
              Arel::Nodes::NamedFunction.new('coalesce', [ 
                gr_num_by_doctype_name('Запись о регистрации права постоянного (бессрочного) пользования'),
                gr_num_by_doctype_name('Свидетельство о праве постоянного (бессрочного) пользования'),
                gr_num_by_doctype_name('Выписка из ЕГРН'),
              ]) 
            )
            .when(Source.___moving_operations[:movetype_name].in(['Балансодержание']))
            .then(
              Arel::Nodes::NamedFunction.new('coalesce', [ 
                gr_num_by_doctype_name('Запись о регистрации права оперативного управления'),
                gr_num_by_doctype_name('Запись о регистрации права хозяйственного ведения'),
                gr_num_by_doctype_name('Свидетельство о праве оперативного управления'),
                gr_num_by_doctype_name('Свидетельство о праве хозяйственного ведения'),
                gr_num_by_doctype_name('Выписка из ЕГРН'),
              ]) 
            )
          
          date_reg =
            Arel::Nodes::Case.new()
            .when(Source.___moving_operations[:movetype_name].in(['Собственность','Купля-продажа']))
            .then(
              Arel::Nodes::NamedFunction.new('coalesce', [ 
                gr_date_by_doctype_name('Запись о регистрации права муниципальной собственности'),
                gr_date_by_doctype_name('Свидетельство муниципальной собственности'),
                gr_date_by_doctype_name('Выписка из ЕГРН'),
              ]) 
            )
            .when(Source.___moving_operations[:movetype_name].in(['Пользование', 'Бессрочное пользование']))
            .then(
              Arel::Nodes::NamedFunction.new('coalesce', [ 
                gr_date_by_doctype_name('Запись о регистрации права постоянного (бессрочного) пользования'),
                gr_date_by_doctype_name('Свидетельство о праве постоянного (бессрочного) пользования'),
                gr_date_by_doctype_name('Выписка из ЕГРН'),
              ]) 
            )
            .when(Source.___moving_operations[:movetype_name].in(['Балансодержание']))
            .then(
              Arel::Nodes::NamedFunction.new('coalesce', [ 
                gr_date_by_doctype_name('Запись о регистрации права оперативного управления'),
                gr_date_by_doctype_name('Запись о регистрации права хозяйственного ведения'),
                gr_date_by_doctype_name('Свидетельство о праве оперативного управления'),
                gr_date_by_doctype_name('Свидетельство о праве хозяйственного ведения'),
                gr_date_by_doctype_name('Выписка из ЕГРН'),
              ]) 
            )

          Source.___moving_operations
          .project([
            Source.___moving_operations[:___link_key].as("link_key"),
            Source.___ids[:link_type],
            Source.___ids[:row_id],
            Source.___moving_operations[:sincedate].as("date_beg"),
            Source.___moving_operations[:enddate].as("date_end"),
            Source.___moving_operations[:sincedate].as("date_mov"),
            Source.___moving_operations[:___link_corr].as("link_corr"),
            num_reg.as("num_reg"),
            date_reg.as("date_reg"),
            Source.___moving_operations[:___link_cause_b].as("link_cause_b"),
            Source.___moving_operations[:___link_cause_e].as("link_decomm_cause"),
            Arel.sql("#{ Destination::MssOacRowstates::CURRENT }").as("link_scd_state")
          ])
          .join(Source.___ids).on(Source.___ids[:id].eq(Source.___moving_operations[:id]).and(Source.___ids[:table_id].eq(Source::MovingOperations.table_id)))
          .where(Source.___ids[:link_type].not_eq(nil))
        end
        
        begin
          sql = ""
          selects = [] 
          unions = []

          Source.execute_query(query.to_sql).each_slice(1000) do |rows|
            rows.each do |row|
              Arel::SelectManager.new.tap do |select|
                selects <<
                  select.project([
                    Arel::Nodes::Quoted.new(row["link_key"]),
                    Arel::Nodes::Quoted.new(row["link_type"]),
                    Arel::Nodes::Quoted.new(row["row_id"]),
                    Arel::Nodes::Quoted.new(row["date_beg"].nil? ? nil : row["date_beg"].strftime("%Y%m%d")),
                    Arel::Nodes::Quoted.new(row["date_end"].nil? ? nil : row["date_end"].strftime("%Y%m%d")),
                    Arel::Nodes::Quoted.new(row["date_mov"].nil? ? nil : row["date_mov"].strftime("%Y%m%d")),
                    Arel::Nodes::Quoted.new(row["link_corr"]),
                    Arel::Nodes::Quoted.new(row["num_reg"]),
                    Arel::Nodes::Quoted.new(row["date_reg"].nil? ? nil : row["date_reg"].strftime("%Y%m%d")),
                    Arel::Nodes::Quoted.new(row["link_cause_b"]),
                    Arel::Nodes::Quoted.new(row["link_decomm_cause"]),
                    Arel::Nodes::Quoted.new(row["link_scd_state"]),
                  ])
              end
            end  
            unions << Arel::Nodes::UnionAll.new(selects[0], selects[1])
            selects[2..-1].each do |select| 
              unions << Arel::Nodes::UnionAll.new(unions.last, select)
            end
            insert_manager = Arel::InsertManager.new(Database.destination_engine).tap do |manager|
              rows.first.keys.each do |column|
                manager.columns << Destination.mss_movs[column.to_sym]
              end
              manager.into(Destination.mss_movs)
              manager.select(unions.last)
            end
            sql = insert_manager.to_sql
          
            #sql = Destination::MssMovs.insert_query(rows: insert, condition: "mss_movs.row_id = values_table.row_id")
            result = Destination.execute_query(sql)
            result.do
            selects.clear
            unions.clear
            sql.clear
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
