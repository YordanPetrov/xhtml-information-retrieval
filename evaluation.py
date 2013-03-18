import os
import subprocess
import urllib2
from BeautifulSoup import BeautifulSoup

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
		script = self.dir + '/test.xsl'
		# xsltproc", "$file", "$file_path/test.xml"
		for name in self.filenames:
			if ".xhtml" in name:
				file_out = "{0}.xml".format(name.split('.')[0])
				out = open(file_out, 'w')
				subprocess.Popen(["xsltproc", script, name], stdout=out)
				out.close()

	def convert(self):
		script = self.dir + '/toHtml.xsl'
		# xsltproc", "$file", "$file_path/test.xml"
		for name in self.filenames:
			if "CognitiveScience.xml" in name:
				file_out = "{0}test.html".format(name.split('.')[0])
				out = open(file_out, 'w')
				subprocess.Popen(["xsltproc", script, name], stdout=out)
				out.close()

	def fetch_pages(self):
		base_url = 'http://www.drps.ed.ac.uk/12-13/dpt/cx_sb_infr.htm'
		base_url2 = 'http://www.drps.ed.ac.uk/12-13/dpt/'
		r = urllib2.urlopen(base_url).read()
		soup = BeautifulSoup(r)
		all_links = soup.findAll('a')
		links = {}
		for link in all_links:
			if "cxinf" in link["href"]:
				links[link["href"]] = base_url2 + link["href"]

		for key, value in links.items():
			file_out = open("pages/" + key, 'w')
			url_r = urllib2.urlopen(value).read()
			file_out.write(url_r)
			file_out.close()