#!/bin/csh
#------------------------------------------------------------------------#
# Shell-id     : supbd1001
# Shell-名     : supbd1001.csh
# 機能         : メニューサービス区分更新処理（県刊行別実績バッチ開始）
#                wtzzom001.sql
#                  PARM1:メニュー単位
#                  PARM2:サービス区分
#                        '00':サービス中
#                        '02':バッチ処理中のためサービス停止
#                        '03':トラブルのためサービス停止
#                        '04':マシン保守のためサービス停止
#                        '21':月次バッチ処理中のためサービス停止
# 作成者       : M.Saitou
# 作成日       : 2003/07/17
# 修正履歴     :
# Ｎｏ   修正日付   修正者     修正内容
#    1  ----/--/--  XXXXXXXXX  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
#---+----1----+----2----+----3----+----4----+----5----+----6----+----7---
#    x  2006/05/12  M.Tanaka    Ｅ１０Ｋ移行ガイドライン対応
#------------------------------------------------------------------------#
#       初期処理部
#------------------------------------------------------------------------#
#E10K BEF#set SUBSRCDIR="/prod/jcl/sub"
set PROD_DIR = /prod
set SUBSRCDIR="${PROD_DIR}/jcl/sub"
#
source $SUBSRCDIR/upbd.src
source $SUBSRCDIR/common.src
#
setenv ORAUID   $ORAUID
setenv ORAUIDL  $ORAUIDL
setenv ORAPWD   $ORAPWD
setenv ORAPWDL  $ORAPWDL
#
#------------------------------------------------------------------------#
#       wtzzom001.sql （110 DEPT-CLASS-SUBCLASS-発行形態）
#------------------------------------------------------------------------#
#E10K BEF#set SQL_PARM=(-s $ORAUID/$ORAPWD @$SQLDIR/wtzzom001.sql 'XY_XYKJ0110' '02')
set SQL_PARM=(-s $ORAUID/$ORAPWD @${PLSQLDIR}/wtzzom001.sql 'XY_XYKJ0110' '02')
#
# ORACLE TABLE SFM_メニュー単位@XXXX
#
source $SUBSRCDIR/execsql.src
if ( $status != $NORMAL ) then
        exit $ABEND
endif
#
#------------------------------------------------------------------------#
#       wtzzom001.sql （120 出版社−発行形態）
#------------------------------------------------------------------------#
#E10K BEF#set SQL_PARM=(-s $ORAUID/$ORAPWD @$SQLDIR/wtzzom001.sql 'XY_XYKJ0120' '02')
set SQL_PARM=(-s $ORAUID/$ORAPWD @${PLSQLDIR}/wtzzom001.sql 'XY_XYKJ0120' '02')
#
# ORACLE TABLE SFM_メニュー単位@XXXX
#
source $SUBSRCDIR/execsql.src
if ( $status != $NORMAL ) then
        exit $ABEND
endif
#
#------------------------------------------------------------------------#
#       wtzzom001.sql （130 出版社　銘柄／発売日（全国）別）
#------------------------------------------------------------------------#
#E10K BEF#set SQL_PARM=(-s $ORAUID/$ORAPWD @$SQLDIR/wtzzom001.sql 'XY_XYKJ0130' '02')
set SQL_PARM=(-s $ORAUID/$ORAPWD @${PLSQLDIR}/wtzzom001.sql 'XY_XYKJ0130' '02')
#
# ORACLE TABLE SFM_メニュー単位@XXXX
#
source $SUBSRCDIR/execsql.src
if ( $status != $NORMAL ) then
        exit $ABEND
endif
#
#------------------------------------------------------------------------#
#       後処理部
#------------------------------------------------------------------------#
echo "$SHELLNAME:t :  end  time : `date +%y/%m/%d:%H:%M:%S`" >> $LOG_FILE
exit $NORMAL
