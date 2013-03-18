import os
import subprocess

class Evaluation():
	"""Evaluation baby"""
	def __init__(self, dir):
		self.dir = dir
		self.filenames = os.listdir(self.dir)

	def tidy(self):
		for name in self.filenames:
			if ".html" in name:
				file_out = "{0}.xhtml".format(name.split('.')[0])
				out = open(file_out, 'w')
				subprocess.Popen(["tidy", "-q", "-asxhtml", "--doctype", "omit", "--numeric-entities", "yes", name], stdout=out)
				out.close()

	def extract(self):
		script = '/Users/yordan/Development/xhtml-information-retrieval/test.xsl'
		# xsltproc", "$file", "$file_path/test.xml"
		for name in self.filenames:
			if ".xhtml" in name:
				file_out = "{0}.xml".format(name.split('.')[0])
				out = open(file_out, 'w')
				subprocess.Popen(["xsltproc", script, name], stdout=out)
				out.close()

	def convert(self):
		return 0
