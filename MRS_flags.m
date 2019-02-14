function MRS_flags(mainfile)
cd /nfs/tpolk/mind/PRACTICE/Shannon/Scripts
options = struct('format','pdf','outputDir',mainfile, 'showCode', false)
publish('QC_MRS.m', options)

end