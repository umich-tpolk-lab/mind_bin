import os

file_list = os.listdir("/nfs/tpolk/mind/subjects/Altered_Figs/")
def id(x):
	return(x[13:14])


new4 = sorted(file_list, key = id, reverse = True)


def id(x):
	return(x[9:12])

task1 = sorted(new4, key = id)

def id(x):
	return(x[-5:])

new = sorted(task1, key = id)


def id(x):
	return(x[5:8])


new2 = sorted(new, key = id)


def id(x):
	return(x[-5:])


new3 = sorted(new2, key = id)



from fpdf import FPDF
pdf = FPDF()
pdf.set_auto_page_break(0)

os.chdir('/nfs/tpolk/mind/subjects/Altered_Figs/')
for thing in new3:
	pdf.add_page()
	pdf.image(thing)

pdf.output("/nfs/tpolk/mind/subjects/Field.pdf", "F")



