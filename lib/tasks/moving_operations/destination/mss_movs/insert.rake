namespace :moving_operations do
  namespace :destination do
    namespace :mss_movs do

      task :insert do |t|
        def gr_num_by_doctype_name(name)
          manager = Arel::SelectManager.new Database.source_engine
          manager.projects(Source.docset_members[:gr_num])
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
          manager = Arel::SelectManager.new Database.source_engine
          manager.projects(Source.docset_members[:gr_num])
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
        end
        
        begin
          sql = ""
          insert = []

          Source.execute_query(query.to_sql).each_slice(1000) do |rows|
          
            rows.each do |row|
              insert << {
                link_key: row["link_key"],
                link_type: row["link_type"],
                row_id: row["row_id"],
                date_beg: row["date_beg"].nil? ? nil : row["date_beg"].strftime("%Y%m%d"),
                date_end: row["date_end"].nil? ? nil : row["date_end"].strftime("%Y%m%d"),
                date_mov: row["date_mov"].nil? ? nil : row["date_mov"].strftime("%Y%m%d"),
                link_corr: row["link_corr"],
                num_reg: row["num_reg"],
                date_reg: row["date_reg"],
                link_cause_b: row["link_cause_b"],
                link_decomm_cause: row["link_decomm_cause"],
                link_scd_state: row["link_scd_state"],
              }
            end
            sql = Destination::MssMovs.insert_query(rows: insert, condition: "mss_movs.row_id = values_table.row_id")
            result = Destination.execute_query(sql)
            result.do
            insert.clear
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
