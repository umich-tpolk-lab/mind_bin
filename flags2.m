function flags(mainfile)
cd /nfs/tpolk/mind/bin
options = struct('format','pdf','outputDir',mainfile, 'showCode', false)
publish('B_M_Sub.m', options)
end