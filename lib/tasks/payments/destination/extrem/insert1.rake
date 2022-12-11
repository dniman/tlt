namespace :payments do
  namespace :destination do
    namespace :extrem do

      task :insert1 do |t|
        def query 
          <<~QUERY
            select *
            into #sys_extrem 
            from ___sys_extrem

            declare @r1_self int
            select top (1) @r1_self = link from rem1 where object = dbo.obj_id('REFERENCE_HANDMADE_VIP')

            declare @DOCUMENTS_0401003A int,
                @DOCUMENTS_ADM_VIP int,
                @CHAIN_PP_ADM int
                
            set @DOCUMENTS_0401003A = dbo.obj_id('DOCUMENTS_0401003A')
            set @DOCUMENTS_ADM_VIP = dbo.obj_id('DOCUMENTS_ADM_VIP')
            set @CHAIN_PP_ADM = dbo.obj_id('CHAIN_PP_ADM')

            declare @out table (link int primary key, row_id uniqueidentifier)

            --update #sys_extrem
            --set row_pp = NEWID()
            --where row_pp is null and upd =1 or LINK < 0	
              
            -- Bug 99935 подготовка к переходу на единый entry.link в связи с ликвидацией триггера вставки в entry
            -- вставляем в entry объект документа
            insert into dbo.entry (object, row_id)
              output inserted.link, inserted.row_id into @out (link,row_id) 
              select @DOCUMENTS_0401003A, se.ROW_PP
                from #sys_extrem se
                    left join S_BACCOUNT sb on se.BACCOUNT=sb.LINK
                where se.LINK < 0		
            -- добавляем последним поле entry, пишем ему соответствие из @out.link
            insert into dbo.REM1(OBJECT,link_self,NUMBER,DATE,DATE_EXEC,CORR,BACCOUNT,ROW_ID, link)
            select @DOCUMENTS_0401003A,case se.[TYPE] when 1 then @r1_self else null end,NUMBER,DATE,DATE_EXEC,sb.corr,sb.LINK,se.ROW_PP, e.link
            from #sys_extrem se
                 left join S_BACCOUNT sb on se.BACCOUNT=sb.LINK
                 join @out e on e.row_id = se.ROW_PP
            where se.LINK < 0		

            insert into T_REM1(REF1,REF2,OBJ_UP,obj_down)
            select @r1_self,r1.link,@DOCUMENTS_ADM_VIP,@CHAIN_PP_ADM
            from #sys_extrem se
              inner join REM1 r1 on r1.ROW_ID = se.row_pp
            where se.type = 2 and se.LINK < 0

            insert into REM2(account,OPER,ORDERS,LINK_UP,ROW_ID)
            select r1.BACCOUNT,null,1,r1.LINK,se.ROW_PP
            from #sys_extrem se
                left join REM1 r1 on se.ROW_PP = r1.ROW_ID
            where se.LINK < 0

            insert into REM3(FIRST_REC,DT_CT,INCOME,SUMMA,ATE,IMNS,STATUS,LINK_UP,ROW_ID)
            select 1,3,kbk.link,se.summa, ate.link, r1.CORR,0,r2.LINK,se.ROW_PP
            from #sys_extrem se
                left join REM1 r1 on se.ROW_PP = r1.ROW_ID		
                  left join REM2 r2 on r2.link_up = r1.link		
                left join S_KBK kbk on se.income is not null and se.income = kbk.LINK or se.income is null and (se.[paycincome] = kbk.CODE and kbk.OBJECT = dbo.obj_id('DICTIONARY_KBK_INC'))
                left join OKTMO ate on se.ate is not null and se.ate= ate.link or se.ate is null and se.[paycate] = ate.code and ate.object = dbo.obj_id('DICTIONARY_OKTMO')
            where se.LINK < 0

            insert into EXTREM ([rem1],[rem3], [number], [date],[DATE_EXEC], [summa], [cppu1], [bic1], [bank_n1], [ks1], [cppu2], [bic2], [bank_n2], [ks2], [paystatus], [paycate], [payreason], [payperiod], [payincnumb], [payincdate], [payinctype], [paycincome], [note1], [ccorr1], [caccount1], [ccorr2], [caccount2], [pay_stack], [corr_n1], [corr_n2], [pay_date], [number_el], [cuid], [payuin])
            select r1.LINK,r3.LINK,
              se.number, se.date, se.date_exec, se.summa, se.cppu1, se.bic1, se.bank_n1, se.ks1, se.cppu2, se.bic2, se.bank_n2, se.ks2, se.paystatus, se.paycate, se.payreason, se.payperiod, se.payincnumb, se.payincdate, se.payinctype, se.paycincome, se.note1, se.ccorr1, se.caccount1, se.ccorr2, se.caccount2, se.pay_stack, se.corr_n1, se.corr_n2, se.pay_date, se.number_el, se.cuid, se.payuin
            from #sys_extrem se
                inner join REM1 r1 on se.ROW_PP = r1.ROW_ID		
                  inner join REM2 r2 on r2.link_up = r1.link
                    inner join REM3 r3 on r2.LINK = r3.LINK_UP						
            where se.LINK < 0

            update r1
            set NUMBER	= se.number,
              DATE	= se.date,
              DATE_EXEC=se.date_exec,
              CORR	= sb.corr,	
              BACCOUNT= se.baccount,
              reg		= 999
            from REM1 r1
                inner join #sys_extrem se on r1.LINK = se.link
                  left join S_BACCOUNT sb on se.BACCOUNT=sb.LINK or sb.LINK = 42000
            where se.upd = 1 and se.LINK > 0	

            update r2
            set 
              account	= se.BACCOUNT,
              OPER	= se.oper,
              ORDERS	= 1	
            from REM1 r1
                inner join #sys_extrem se on r1.LINK = se.link
                  inner join rem2 r2 on r2.LINK_UP = r1.link			
            where se.upd = 1 and se.LINK > 0

            update r3 set
              FIRST_REC	= 1,
              DT_CT		= 3,
              INCOME		= kbk.link,
              SUMMA		= se.summa,
              ATE			= ate.link,
              IMNS		= r1.CORR,
              STATUS		= 0
            from #sys_extrem se
                inner join REM1 r1 on r1.LINK = se.link		
                  inner join REM2 r2 on r2.link_up = r1.link		
                    inner join REM3 r3 on r3.link_up = r2.link	
                left join S_KBK kbk on se.income is not null and se.income = kbk.LINK or se.income is null and (se.[paycincome] = kbk.CODE and kbk.OBJECT = dbo.obj_id('DICTIONARY_KBK_INC'))
                left join OKTMO ate on se.ate is not null and se.ate= ate.link or se.ate is null and se.[paycate] = ate.code and ate.object = dbo.obj_id('DICTIONARY_OKTMO')
            where se.upd = 1 and se.LINK > 0

            update e set
               [number]=se.number,
               [date]=se.date,
               [DATE_EXEC]=se.date_exec, 
               [summa]=se.summa, 
               [cppu1]=se.cppu1, 
               [bic1]=se.bic1, 
               [bank_n1]=se.bank_n1, 
               [ks1]=se.ks1, 
               [cppu2]=se.cppu2, 
               [bic2]=se.bic2, 
               [bank_n2]=se.bank_n2, 
               [ks2]=se.ks2, 
               [paystatus]=se.paystatus, 
               [paycate]=se.paycate, 
               [payreason]=se.payreason, 
               [payperiod]=se.payperiod, 
               [payincnumb]=se.payincnumb, 
               [payincdate]=se.payincdate, 
               [payinctype]=se.payinctype, 
               [paycincome]=se.paycincome, 
               [note1]=se.note1, 
               [ccorr1]=se.ccorr1, 
               [caccount1]=se.caccount1, 
               [ccorr2]=se.ccorr2, 
               [caccount2]=se.caccount2, 
               [pay_stack]=se.pay_stack, 
               [corr_n1]=se.corr_n1, 
               [corr_n2]=se.corr_n2, 
               [pay_date]=se.pay_date, 
               [number_el]=se.number_el, 
               [cuid]=se.cuid, 
               [payuin]=se.payuin
            from #sys_extrem se
                inner join REM1 r1 on r1.LINK = se.link		
                  inner join extrem e on e.rem1 = r1.link
            where se.upd = 1 and se.LINK > 0		
            select * from #sys_extrem se
                inner join REM1 r1 on r1.LINK = se.link		
                  inner join extrem e on e.rem1 = r1.link		

            declare @reference_pay_credit int = dbo.obj_id('REFERENCE_PAY_CREDIT')
            declare @reference_pay_debit int = dbo.obj_id('REFERENCE_PAY_DEBIT')
            
            insert into dbo.t_charge ([object], pc, extrem, rdate, date_exec, summa_a, summa_p, summa_s, row_id)
            select
              case when ___sys_extrem.summa < 0 then @reference_pay_debit else @reference_pay_credit end
              ,___sys_extrem.pc
              ,extrem.link
              ,___sys_extrem.date_exec
              ,___sys_extrem.date_exec
              ,___sys_extrem.summa_a
              ,___sys_extrem.summa_p
              ,null as summa_s
              ,___sys_extrem.row_pp
            from ___sys_extrem
              join extrem on extrem.row_id = ___sys_extrem.row_pp
            where not exists(select * from t_charge where row_id = ___sys_extrem.row_pp)
          QUERY
        end
        
        begin
          Destination.execute_query(query).do

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
