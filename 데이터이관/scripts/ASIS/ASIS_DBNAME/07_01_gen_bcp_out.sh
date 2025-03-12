cd ./bcp/bcp_out
sh gen_bcp_out_unix.sh password


cd /app/sybase/NO_DEL/03_ASE_MIG/D_DAY/ASIS/ASIS_DBNAME/bcp/bcp_out/USERDB4

sed -i 's/\.\./\.dbo\./g' bcp_out_v_tax_siljuk_2016.sh
sed -i 's/\.\./\.dbo\./g' bcp_out_tb_co06dt_040629_2.sh
sed -i 's/\.\./\.dbo\./g' bcp_out_tb_co06ld_040629.sh

#sed -i 's/sh bcp_out_AB01_TMP.sh/#sh bcp_out_AB01_TMP.sh/g'  ALL_BCP_OUT.sh
#sed -i 's/sh bcp_out_CP_COM_TRANSLOG.sh/#sh bcp_out_CP_COM_TRANSLOG.sh/g'  ALL_BCP_OUT.sh
#sed -i 's/sh bcp_out_TB_RC_TRANS_LOG.sh/#sh bcp_out_TB_RC_TRANS_LOG.sh/g'  ALL_BCP_OUT.sh
#sed -i 's/sh bcp_out_TB_REQUEST.sh/#sh bcp_out_TB_REQUEST.sh/g'  ALL_BCP_OUT.sh
#sed -i 's/sh bcp_out_tb_cp_mon_sum.sh/#sh bcp_out_tb_cp_mon_sum.sh/g'  ALL_BCP_OUT.sh
#sed -i 's/sh bcp_out_tb_css_ass_etcinfo.sh/#sh bcp_out_tb_css_ass_etcinfo.sh/g'  ALL_BCP_OUT.sh
#sed -i 's/sh bcp_out_tb_css_ass_nice_cbinfo.sh/#sh bcp_out_tb_css_ass_nice_cbinfo.sh/g'  ALL_BCP_OUT.sh
#sed -i 's/sh bcp_out_tb_css_bs1_stg.sh/#sh bcp_out_tb_css_bs1_stg.sh/g'  ALL_BCP_OUT.sh
#sed -i 's/sh bcp_out_tb_st20ld.sh/#sh bcp_out_tb_st20ld.sh/g'  ALL_BCP_OUT.sh
#sed -i 's/sh bcp_out_temp_131011_11.sh/#sh bcp_out_temp_131011_11.sh/g'  ALL_BCP_OUT.sh


cd /app/sybase/NO_DEL/03_ASE_MIG/D_DAY/ASIS/ASIS_DBNAME/bcp/bcp_out/USERDB5


sed -i 's/\.\./\.dbo\./g' bcp_out_v_tax_siljuk_2016.sh
sed -i 's/\.\./\.dbo\./g' bcp_out_tb_co06dt_040629_2.sh
sed -i 's/\.\./\.dbo\./g' bcp_out_tb_co06ld_040629.sh

#sed -i 's/sh bcp_out_CP_COM_TRANSLOG.sh/#sh bcp_out_CP_COM_TRANSLOG.sh/g'  ALL_BCP_OUT.sh
#sed -i 's/sh bcp_out_tb_css_ass_nice_cbinfo.sh/#sh bcp_out_tb_css_ass_nice_cbinfo.sh/g'  ALL_BCP_OUT.sh
#sed -i 's/sh bcp_out_tb_css_bs1_stg.sh/#sh bcp_out_tb_css_bs1_stg.sh/g'  ALL_BCP_OUT.sh
#sed -i 's/sh bcp_out_tb_in08ld.sh/#sh bcp_out_tb_in08ld.sh/g'  ALL_BCP_OUT.sh
#sed -i 's/sh bcp_out_tb_in09ld.sh/#sh bcp_out_tb_in09ld.sh/g'  ALL_BCP_OUT.sh
#sed -i 's/sh bcp_out_tb_st57ld.sh/#sh bcp_out_tb_st57ld.sh/g'  ALL_BCP_OUT.sh
#sed -i 's/sh bcp_out_temp_131011_11.sh/#sh bcp_out_temp_131011_11.sh/g'  ALL_BCP_OUT.sh

cd /app/sybase/NO_DEL/03_ASE_MIG/D_DAY/ASIS/ASIS_DBNAME/bcp/bcp_out/USERDB1

#sed -i 's/sh bcp_out_tb_css_bs0_nice_cbinfo.sh/#sh bcp_out_tb_css_bs0_nice_cbinfo.sh/g'  ALL_BCP_OUT.sh
#sed -i 's/sh bcp_out_tb_css_bss_nice_cbinfo.sh/#sh bcp_out_tb_css_bss_nice_cbinfo.sh/g'  ALL_BCP_OUT.sh
#sed -i 's/sh bcp_out_tb_css_kis_fin.sh/#sh bcp_out_tb_css_kis_fin.sh/g'  ALL_BCP_OUT.sh

cd /app/sybase/NO_DEL/03_ASE_MIG/D_DAY/ASIS/ASIS_DBNAME/bcp/bcp_out/USERDB3

#sed -i 's/sh bcp_out_tb_in10dd_2014.sh/#sh bcp_out_tb_in10dd_2014.sh/g'  ALL_BCP_OUT.sh
#sed -i 's/sh bcp_out_tb_st20ld_2010.sh/#sh bcp_out_tb_st20ld_2010.sh/g'  ALL_BCP_OUT.sh
#sed -i 's/sh bcp_out_tb_sys21ld_2018.sh/#sh bcp_out_tb_sys21ld_2018.sh/g'  ALL_BCP_OUT.sh
