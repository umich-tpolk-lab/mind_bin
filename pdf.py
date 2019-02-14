import os


from PyPDF2 import PdfFileMerger, PdfFileReader
merger = PdfFileMerger()
filename2 = "/nfs/tpolk/mind/subjects/B_M_Total.pdf"
filename3 = "/nfs/tpolk/mind/subjects/B_M_Sub.pdf"
filename4 = "/nfs/tpolk/mind/subjects/Field.pdf"
filename5 = "/nfs/tpolk/mind/subjects/Subject.pdf"

merger.append(PdfFileReader(filename2, 'rb'))
merger.append(PdfFileReader(filename4, 'rb'))

os.chdir('/nfs/tpolk/mind/subjects/')
merger.write("By_Fields.pdf")


from PyPDF2 import PdfFileMerger, PdfFileReader
merger = PdfFileMerger()
merger.append(PdfFileReader(filename3, 'rb'))
merger.append(PdfFileReader(filename5, 'rb'))

os.chdir('/nfs/tpolk/mind/subjects/')
merger.write("By_Subject.pdf")



