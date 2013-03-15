import os
from subprocess import call

class Evaluation():
	"""Evaluation baby"""
	def __init__(self, dir):
		self.dir = dir
		self.filenames = os.listdir(self.dir)

	def tidy(self):
		for name in self.filenames:
			if ".html" in name:
				file_in = name
				file_out = "tidy/{0}.xhtml".format(name.split('.')[0])
			      # FunctionalProgramming.html > FunctionalProgramming.xhtml
				call(["tidy", "-q", "-asxhtml", "--doctype", "omit", "--numeric-entities", "yes", file_in, ">", file_out])
		 

	def extract(self):
		return 0

	def convert(self):
		return 0
