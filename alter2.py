import sys

def alter(x, y, z):
	import os

	from PIL import Image
	from PIL import ImageFont
	from PIL import ImageDraw
	img1 = x
	img2 = y
	imname = z
	img = Image.open(img1)
	fontPath = "/usr/share/fonts/dejavu/DejaVuSerif.ttf"
	serif32 = ImageFont.truetype(fontPath, 32)
	draw = ImageDraw.Draw(img)
	draw.text((0,0), "" + imname + "", (0), font=serif32)
	draw = ImageDraw.Draw(img)
	img.save(img2)
	import PIL
	from PIL import Image
	basewidth = 600
	img = Image.open(img2)
	wpercent = (basewidth / float(img.size[0]))
	hsize = int((float(img.size[1]) * float(wpercent)))
	img = img.resize((basewidth, hsize), PIL.Image.ANTIALIAS)
	img.save(img2)

if __name__ == '__main__':
    # Map command line arguments to function arguments.
    alter(*sys.argv[1:])
